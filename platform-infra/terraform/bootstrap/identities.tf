# Read-only identity for pull-request plans.
resource "google_service_account" "terraform_plan" {
  project      = var.project_id
  account_id   = var.plan_service_account_id
  display_name = "Kaveri Terraform Plan (read-only)"
  description  = "Federated read-only identity for PR terraform plan."
  depends_on   = [google_project_service.identity_apis]
}

# Apply identity, usable only from approved GitHub environments.
resource "google_service_account" "terraform_deployer" {
  project      = var.project_id
  account_id   = var.deployer_service_account_id
  display_name = "Kaveri Terraform Deployer"
  description  = "Federated identity for approved terraform apply."
  depends_on   = [google_project_service.identity_apis]
}

# Any workflow run in the platform repo (including PRs) may use the plan identity.
resource "google_service_account_iam_member" "plan_wif" {
  service_account_id = google_service_account.terraform_plan.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository/${var.github_owner}/${var.github_repository}"
}

# Only jobs running in an approved GitHub environment may use the deployer.
# GitHub sets the token subject to repo:<owner>/<repo>:environment:<env> for such jobs.
resource "google_service_account_iam_member" "deployer_wif" {
  for_each = toset(var.github_deploy_environments)

  service_account_id = google_service_account.terraform_deployer.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/subject/repo:${var.github_owner}/${var.github_repository}:environment:${each.value}"
}
