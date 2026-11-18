variable "project_id" {
  description = "GCP project ID for Kaveri DEV."
  type        = string
  default     = "vibrant-chain-514216-p4"
}

variable "region" {
  description = "Primary GCP region for Kaveri DEV."
  type        = string
  default     = "asia-south1"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"

  validation {
    condition     = var.environment == "dev"
    error_message = "This Terraform root is dedicated to DEV."
  }
}

variable "network_name" {
  description = "Kaveri DEV VPC name."
  type        = string
  default     = "kaveri-dev-vpc"
}

variable "subnet_name" {
  description = "Kaveri DEV subnet name."
  type        = string
  default     = "kaveri-dev-subnet"
}

variable "subnet_cidr" {
  description = "Primary DEV subnet CIDR."
  type        = string
  default     = "10.10.1.0/24"
}

variable "pod_cidr" {
  description = "GKE pod secondary range."
  type        = string
  default     = "10.20.0.0/16"
}

variable "service_cidr" {
  description = "GKE service secondary range."
  type        = string
  default     = "10.30.0.0/20"
}

variable "master_ipv4_cidr_block" {
  description = "GKE control plane CIDR."
  type        = string
  default     = "172.16.0.0/28"
}

variable "labels" {
  description = "Common Kaveri DEV resource labels."
  type        = map(string)

  default = {
    application = "kaveri"
    environment = "dev"
    managed_by  = "terraform"
    project     = "platform-engineering"
    owner       = "devops"
  }
}
