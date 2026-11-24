variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "location" {
  description = "Artifact Registry region"
  type        = string
  default     = "asia-south1"
}

variable "repository_id" {
  description = "Artifact Registry repository name"
  type        = string
}

variable "format" {
  description = "Artifact package format"
  type        = string
  default     = "DOCKER"
}

variable "mode" {
  description = "Repository mode"
  type        = string
  default     = "STANDARD_REPOSITORY"
}

variable "description" {
  description = "Repository description"
  type        = string
  default     = "Corporate microservices Docker image repository"
}

variable "labels" {
  description = "Labels assigned to the repository"
  type        = map(string)
  default     = {}
}

variable "kms_key_name" {
  description = "Optional Cloud KMS encryption key"
  type        = string
  default     = null
}

variable "docker_config" {
  description = "Docker repository configuration"
  type = object({
    immutable_tags = optional(bool)
  })
  default = {
    immutable_tags = true
  }
}

variable "cleanup_policy_dry_run" {
  description = "Run cleanup policies in dry-run mode"
  type        = bool
  default     = true
}

variable "cleanup_policies" {
  description = "Artifact Registry cleanup policies"
  type = map(object({
    action = optional(string)
    condition = optional(object({
      tag_state             = optional(string)
      tag_prefixes          = optional(list(string))
      version_name_prefixes = optional(list(string))
      package_name_prefixes = optional(list(string))
      older_than            = optional(string)
      newer_than            = optional(string)
    }), null)
    most_recent_versions = optional(object({
      package_name_prefixes = optional(list(string))
      keep_count            = optional(number)
    }), null)
  }))
  default = {}
}

variable "enable_vpcsc_policy" {
  description = "Enable VPC Service Controls policy"
  type        = bool
  default     = false
}


variable "members" {
  description = "Artifact Registry reader and writer IAM members"
  type        = map(list(string))
  default     = {}

  validation {
    condition = alltrue([
      for key in keys(var.members) : contains(["readers", "writers"], key)
    ])
    error_message = "Supported keys are readers and writers."
  }
}
