module "gcs_remote_state" {
  source = "../modules/gcs-remote-state"

  project_id    = var.project_id
  bucket_prefix = var.bucket_prefix
  bucket_suffix = var.bucket_suffix
  location      = var.location
  labels        = var.labels
}

# Enable APIs required for Workload Identity Federation.
resource "google_project_service" "identity_apis" {
  for_each = toset([
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com"
  ])

  project                    = var.project_id
  service                    = each.value
  disable_on_destroy         = false
  disable_dependent_services = false
}

# Trust boundary for external CI/CD identities.
resource "google_iam_workload_identity_pool" "github" {
  project                   = var.project_id
  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = "Kaveri GitHub Actions Pool"
  description               = "Federation pool for the Kaveri infrastructure repository."
  disabled                  = false

  depends_on = [
    google_project_service.identity_apis
  ]
}

# Validate identity tokens issued by GitHub Actions.
resource "google_iam_workload_identity_pool_provider" "github" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_provider_id

  display_name = "Kaveri GitHub OIDC Provider"

  attribute_mapping = {
    "google.subject"        = "assertion.sub"
    "attribute.repository"  = "assertion.repository"
    "attribute.ref"         = "assertion.ref"
    "attribute.environment" = "assertion.environment"
  }
  attribute_condition = "assertion.repository == '${var.github_owner}/${var.github_repository}' && assertion.ref == 'refs/heads/${var.github_branch}' && assertion.environment == '${var.github_environment}'"


  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  depends_on = [
    google_iam_workload_identity_pool.github
  ]
}

# Dedicated identity used by Terraform in GitHub Actions.
resource "google_service_account" "terraform_deployer" {
  project      = var.project_id
  account_id   = var.deployer_service_account_id
  display_name = "Kaveri Terraform GitHub Actions Deployer"
  description  = "Federated identity for automated Kaveri infrastructure deployments."

  depends_on = [
    google_project_service.identity_apis
  ]
}

# Permit only tokens matching the repository attribute to impersonate
# this service account. The provider condition also enforces branch
# and GitHub environment restrictions.
resource "google_service_account_iam_member" "github_deployer" {
  service_account_id = google_service_account.terraform_deployer.name
  role               = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository/${var.github_owner}/${var.github_repository}"

  depends_on = [
    google_iam_workload_identity_pool_provider.github
  ]
}

# Grant the Terraform deployment identity access to this state bucket only.
resource "google_storage_bucket_iam_member" "terraform_state_access" {
  bucket = module.gcs_remote_state.bucket_name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.terraform_deployer.email}"

  depends_on = [
    module.gcs_remote_state,
    google_service_account.terraform_deployer
  ]
}

# Permissions required by the GitHub Actions Terraform deployment identity.
# These roles are restricted to the Kaveri GCP project.
locals {
  terraform_deployer_project_roles = toset([
    "roles/serviceusage.serviceUsageAdmin",
    "roles/compute.networkAdmin",
    "roles/compute.securityAdmin",
    "roles/container.admin",
    "roles/artifactregistry.admin",
    "roles/secretmanager.admin",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountUser",
    "roles/monitoring.editor",
    "roles/resourcemanager.projectIamAdmin"
  ])
}

resource "google_project_iam_member" "terraform_deployer" {
  for_each = local.terraform_deployer_project_roles

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.terraform_deployer.email}"

  depends_on = [
    google_service_account.terraform_deployer,
    google_project_service.identity_apis
  ]
}
