variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "secrets" {
  description = "Secret CONTAINERS (metadata only). Secret values never pass through Terraform - they are injected out-of-band, so nothing here is sensitive and nothing reaches state."
  type = list(object({
    name               = string
    rotation_period    = optional(string)
    next_rotation_time = optional(string)
  }))
  default = []

  validation {
    condition     = alltrue([for s in var.secrets : can(regex("^[A-Za-z0-9_-]{1,255}$", s.name))])
    error_message = "Secret names may contain only letters, digits, '_' and '-', 1-255 characters."
  }
}

variable "labels" {
  description = "Labels assigned to individual secrets"
  type        = map(map(string))
  default     = {}
}

variable "automatic_replication" {
  description = "Automatic replication configuration with optional CMEK"
  type = map(object({
    kms_key_name = string
  }))
  default = {}
}

variable "user_managed_replication" {
  description = "User-managed replication locations and CMEK keys"
  type = map(list(object({
    location     = string
    kms_key_name = string
  })))
  default = {}
}

variable "secret_accessors_list" {
  description = "IAM members permitted to access managed secrets"
  type        = list(string)
  default     = []
}

variable "topics" {
  description = "Pub/Sub topics for secret rotation notifications"
  type = map(list(object({
    name = string
  })))
  default = {}
}

variable "add_kms_permissions" {
  description = "KMS crypto key resources requiring Secret Manager permissions"
  type        = list(string)
  default     = []
}

variable "add_pubsub_permissions" {
  description = "Pub/Sub topic resources requiring Secret Manager permissions"
  type        = list(string)
  default     = []
}
