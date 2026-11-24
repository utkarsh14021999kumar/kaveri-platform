variable "project_id" {
  description = "GCP project ID hosting the Terraform state bucket"
  type        = string
  default     = "vibrant-chain-514216-p4"
}

variable "bucket_prefix" {
  description = "Prefix used to generate the state bucket name"
  type        = string
  default     = "vibrant-chain-514216-p4"
}

variable "bucket_suffix" {
  description = "Suffix used to generate the state bucket name"
  type        = string
  default     = "tfstate"
}

variable "location" {
  description = "GCS bucket location"
  type        = string
  default     = "ASIA-SOUTH1"
}

variable "labels" {
  description = "Labels applied to the GCS state bucket"
  type        = map(string)

  default = {
    purpose     = "terraform-state"
    environment = "platform"
    managed_by  = "terraform"
  }
}

variable "log_bucket" {
  description = "Bucket that receives access logs for this bucket (CKV_GCP_62). Null disables access logging."
  type        = string
  default     = null
}
