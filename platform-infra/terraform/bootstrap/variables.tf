variable "project_id" {
  description = "GCP project hosting Terraform state"
  type        = string
  default     = "vibrant-chain-514216-p4"
}

variable "bucket_prefix" {
  description = "Prefix for Terraform state bucket"
  type        = string
  default     = "vibrant-chain-514216-p4"
}

variable "bucket_suffix" {
  description = "Suffix for Terraform state bucket"
  type        = string
  default     = "tfstate"
}

variable "location" {
  description = "GCS bucket location"
  type        = string
  default     = "ASIA-SOUTH1"
}

variable "labels" {
  description = "Labels applied to the state bucket"
  type        = map(string)

  default = {
    purpose     = "terraform-state"
    environment = "platform"
    managed_by  = "terraform"
  }
}

# GitHub repository allowed to authenticate to GCP.
variable "github_owner" {
  description = "GitHub organization or user that owns the repository."
  type        = string
  default     = "utkarsh14021999kumar"
}

variable "github_repository" {
  description = "GitHub repository name allowed to authenticate."
  type        = string
  default     = "kaverigcp"
}

variable "github_branch" {
  description = "Git branch permitted to deploy infrastructure."
  type        = string
  default     = "master"
}

variable "github_environment" {
  description = "GitHub deployment environment required for infrastructure deployment."
  type        = string
  default     = "dev"
}

variable "workload_identity_pool_id" {
  description = "ID of the GitHub Workload Identity Pool."
  type        = string
  default     = "kaveri-github-pool"
}

variable "workload_identity_provider_id" {
  description = "ID of the GitHub OIDC provider."
  type        = string
  default     = "github-oidc-provider"
}

variable "deployer_service_account_id" {
  description = "Dedicated service account ID for Terraform deployments."
  type        = string
  default     = "kaveri-terraform-deployer"
}
