output "terraform_state_bucket_name" {
  description = "Terraform remote state bucket name"
  value       = module.gcs_remote_state.bucket_name
}

output "terraform_state_bucket_url" {
  description = "Terraform remote state bucket URL"
  value       = module.gcs_remote_state.bucket_url
}

output "terraform_state_bucket_names" {
  description = "Generated Terraform state bucket names"
  value       = module.gcs_remote_state.bucket_names
}

output "terraform_state_bucket_urls" {
  description = "Generated Terraform state bucket URLs"
  value       = module.gcs_remote_state.bucket_urls
}

output "terraform_state_bucket_location" {
  description = "Terraform state bucket location"
  value       = var.location
}

output "github_workload_identity_provider_name" {
  description = "Full Workload Identity Federation provider resource name."
  value       = google_iam_workload_identity_pool_provider.github.name
}

output "github_terraform_deployer_service_account" {
  description = "Service account used by GitHub Actions Terraform deployments."
  value       = google_service_account.terraform_deployer.email
}

output "github_workload_identity_pool_name" {
  description = "Full Workload Identity Pool resource name."
  value       = google_iam_workload_identity_pool.github.name
}
