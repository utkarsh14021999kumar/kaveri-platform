variable "project_id" {
  description = "GCP project hosting the platform."
  type        = string
  default     = "vibrant-chain-514216-p4"
}

variable "bucket_prefix" {
  description = "Prefix for the Terraform state bucket."
  type        = string
  default     = "vibrant-chain-514216-p4"
}

variable "bucket_suffix" {
  description = "Suffix for the Terraform state bucket."
  type        = string
  default     = "tfstate"
}

variable "location" {
  description = "State bucket location."
  type        = string
  default     = "ASIA-SOUTH1"
}

variable "labels" {
  description = "Labels applied to the state bucket."
  type        = map(string)
  default = {
    purpose     = "terraform-state"
    environment = "platform"
    managed_by  = "terraform"
  }
}

variable "github_owner" {
  description = "GitHub user/org that owns the platform repository."
  type        = string
  default     = "utkarsh14021999kumar"
}

variable "github_repository" {
  description = "Platform repository allowed to authenticate (ADR-0001)."
  type        = string
  default     = "kaveri-platform"
}

variable "github_deploy_environments" {
  description = "GitHub environments whose jobs may impersonate the deployer."
  type        = list(string)
  default     = ["dev"]
  validation {
    condition     = alltrue([for e in var.github_deploy_environments : contains(["dev", "qa", "uat", "prod"], e)])
    error_message = "Allowed environments: dev, qa, uat, prod."
  }
}

variable "workload_identity_pool_id" {
  description = "Workload Identity Pool ID."
  type        = string
  default     = "kaveri-github-pool"
}

variable "workload_identity_provider_id" {
  description = "GitHub OIDC provider ID."
  type        = string
  default     = "github-oidc-provider"
}

variable "deployer_service_account_id" {
  description = "Account ID of the apply (deployer) identity."
  type        = string
  default     = "kaveri-terraform-deployer"
}

variable "plan_service_account_id" {
  description = "Account ID of the read-only plan identity."
  type        = string
  default     = "kaveri-terraform-plan"
}

variable "deployer_project_roles" {
  description = "Least-privilege project roles for the deployer."
  type        = list(string)
  default = [
    "roles/serviceusage.serviceUsageAdmin",
    "roles/compute.networkAdmin",
    "roles/compute.securityAdmin",
    "roles/container.clusterAdmin",
    "roles/artifactregistry.admin",
    "roles/secretmanager.admin",
    "roles/iam.serviceAccountAdmin",
    "roles/monitoring.alertPolicyEditor",
    "roles/browser",
  ]
  validation {
    condition     = alltrue([for r in var.deployer_project_roles : startswith(r, "roles/")]) && !contains(var.deployer_project_roles, "roles/owner") && !contains(var.deployer_project_roles, "roles/editor")
    error_message = "Roles must start with roles/ and must not include roles/owner or roles/editor."
  }
}

variable "deployer_grantable_roles" {
  description = "The only roles the deployer may grant/revoke via conditional projectIamAdmin."
  type        = list(string)
  default     = ["roles/container.defaultNodeServiceAccount"]
}

variable "plan_project_roles" {
  description = "Read-only project roles for the plan identity."
  type        = list(string)
  default = [
    "roles/iam.securityReviewer",
    "roles/browser",
    "roles/compute.viewer",
    "roles/container.viewer",
    "roles/artifactregistry.reader",
    "roles/secretmanager.viewer",
    "roles/monitoring.viewer",
    "roles/serviceusage.serviceUsageViewer",
    "roles/iam.serviceAccountViewer",
  ]
  validation {
    condition     = length(setintersection(var.plan_project_roles, ["roles/viewer", "roles/editor", "roles/owner"])) == 0
    error_message = "Plan identity must not use basic roles (viewer/editor/owner) - CKV_GCP_117."
  }
}

variable "github_owner_id" {
  description = "Immutable numeric ID of the GitHub owner (used in the immutable OIDC subject)."
  type        = string
  default     = "184352890"
  validation {
    condition     = can(regex("^[0-9]+$", var.github_owner_id))
    error_message = "github_owner_id must be numeric."
  }
}

variable "github_repository_id" {
  description = "Immutable numeric ID of the platform repository (used in the immutable OIDC subject)."
  type        = string
  default     = "1468204581"
  validation {
    condition     = can(regex("^[0-9]+$", var.github_repository_id))
    error_message = "github_repository_id must be numeric."
  }
}

variable "billing_account_id" {
  description = "Billing account for the budget. Supplied via TF_VAR_billing_account_id (not committed)."
  type        = string
}

variable "budget_alert_email" {
  description = "Email for budget alerts. Supplied via TF_VAR_budget_alert_email (not committed)."
  type        = string
}

variable "budget_amount_inr" {
  description = "Monthly budget in INR; alerts at 25/50/100% (500/1000/2000 for 2000)."
  type        = number
  default     = 2000

  validation {
    condition     = var.budget_amount_inr > 0
    error_message = "budget_amount_inr must be positive."
  }
}
