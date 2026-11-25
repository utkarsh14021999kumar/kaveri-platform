# GitHub immutable OIDC subject prefix: repo:<owner>@<owner_id>/<repo>@<repo_id>
locals {
  github_sub_prefix = "repo:${var.github_owner}@${var.github_owner_id}/${var.github_repository}@${var.github_repository_id}"
}

resource "google_service_account" "terraform_plan" {
  project      = var.project_id
  account_id   = var.plan_service_account_id
  display_name = "Kaveri Terraform Plan (read-only)"
  description  = "Federated read-only identity for PR terraform plan."
  depends_on   = [google_project_service.identity_apis]
}

resource "google_service_account" "terraform_deployer" {
  project      = var.project_id
  account_id   = var.deployer_service_account_id
  display_name = "Kaveri Terraform Deployer"
  description  = "Federated identity for approved terraform apply."
  depends_on   = [google_project_service.identity_apis]
}

# Any workflow run in the platform repo (matched by immutable repository ID) may use the plan identity.
resource "google_service_account_iam_member" "plan_wif" {
  service_account_id = google_service_account.terraform_plan.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository_id/${var.github_repository_id}"
}

# Only jobs running in an approved GitHub environment may use the deployer.
resource "google_service_account_iam_member" "deployer_wif" {
  for_each = toset(var.github_deploy_environments)

  service_account_id = google_service_account.terraform_deployer.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/subject/${local.github_sub_prefix}:environment:${each.value}"
}

# CI image pusher for kaveri-boutique: no project roles; writer on one Artifact Registry repository (#72).
resource "google_service_account" "ci_image_pusher" {
  project      = var.project_id
  account_id   = var.image_pusher_service_account_id
  display_name = "KAVERI CI image pusher (kaveri-boutique)"
  description  = "Pushes images to kaveri-dev-docker from kaveri-boutique main only. No other roles."
}

resource "google_service_account_iam_member" "ci_image_pusher_wif" {
  service_account_id = google_service_account.ci_image_pusher.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository_id/${var.boutique_repository_id}"
}
