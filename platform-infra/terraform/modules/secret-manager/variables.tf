variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "secrets" {
  description = "Secret definitions. Secret data should be supplied through a secure process."
  type = list(object({
    name               = string
    secret_data        = optional(string)
    next_rotation_time = optional(string)
    rotation_period    = optional(string)
    create_version     = optional(bool, false)
  }))
  default   = []
  sensitive = true
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
