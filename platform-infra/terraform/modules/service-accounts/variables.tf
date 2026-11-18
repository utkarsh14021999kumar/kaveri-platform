variable "project_id" {
  description = "GCP project ID where service accounts will be created"
  type        = string
}

variable "prefix" {
  description = "Prefix for service account names"
  type        = string
  default     = "kaveri"
}

variable "names" {
  description = "Names of service accounts to create"
  type        = list(string)
  default     = []
}

variable "description" {
  description = "Default description for service accounts"
  type        = string
  default     = "Corporate GCP platform service account"
}

variable "descriptions" {
  description = "Individual service account descriptions"
  type        = list(string)
  default     = []
}

variable "display_name" {
  description = "Display name for created service accounts"
  type        = string
  default     = "Kaveri GCP Platform Service Account"
}

variable "disabled" {
  description = "Map of service account names to disabled status"
  type        = map(bool)
  default     = {}
}

variable "project_roles" {
  description = "Optional project-level IAM roles in project_id=>role format"
  type        = list(string)
  default     = []
}
