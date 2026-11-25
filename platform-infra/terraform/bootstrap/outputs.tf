output "terraform_state_bucket_name" {
  description = "Terraform remote state bucket name."
  value       = module.gcs_remote_state.bucket_name
}

output "terraform_state_bucket_url" {
  description = "Terraform remote state bucket URL."
  value       = module.gcs_remote_state.bucket_url
}

output "github_workload_identity_provider_name" {
  description = "Full WIF provider resource name (used by google-github-actions/auth)."
  value       = google_iam_workload_identity_pool_provider.github.name
}

output "terraform_deployer_service_account" {
  description = "Apply identity (environment-gated)."
  value       = google_service_account.terraform_deployer.email
}

output "terraform_plan_service_account" {
  description = "Read-only plan identity (PRs)."
  value       = google_service_account.terraform_plan.email
}

output "github_actions_variables" {
  description = "Identifiers (not secrets) for GitHub Actions repository variables."
  value = {
    GCP_PROJECT_ID   = var.project_id
    GCP_WIF_PROVIDER = google_iam_workload_identity_pool_provider.github.name
    GCP_DEPLOYER_SA  = google_service_account.terraform_deployer.email
    GCP_PLAN_SA      = google_service_account.terraform_plan.email
    TF_STATE_BUCKET  = module.gcs_remote_state.bucket_name
  }
}

output "ci_image_pusher_email" {
  description = "Service account used by kaveri-boutique CI to push images."
  value       = google_service_account.ci_image_pusher.email
}

output "boutique_wif_provider" {
  description = "Full resource name of the kaveri-boutique WIF provider (GitHub variable GCP_WIF_PROVIDER in kaveri-boutique)."
  value       = google_iam_workload_identity_pool_provider.github_boutique.name
}
