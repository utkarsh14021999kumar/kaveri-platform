variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "asia-south1"
}

variable "network_name" {
  description = "GCP VPC network name"
  type        = string
}

variable "subnet_name" {
  description = "GCP subnet name"
  type        = string
}

variable "subnet_cidr" {
  description = "Primary subnet CIDR range"
  type        = string
}

variable "pod_cidr" {
  description = "GKE Pod secondary CIDR range"
  type        = string
}

variable "service_cidr" {
  description = "GKE Service secondary CIDR range"
  type        = string
}
