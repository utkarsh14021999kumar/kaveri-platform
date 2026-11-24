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
  description = "Primary subnet range (canonical IPv4 CIDR, e.g. 10.10.1.0/24)."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.subnet_cidr)) && can(cidrsubnet(var.subnet_cidr, 0, 0)) && try(cidrsubnet(var.subnet_cidr, 0, 0) == var.subnet_cidr, false)
    error_message = "subnet_cidr must be a valid canonical IPv4 CIDR with no host bits set (e.g. 10.10.1.0/24, not 10.10.1.5/24)."
  }
}

variable "pod_cidr" {
  description = "Secondary range for GKE Pods (canonical IPv4 CIDR, e.g. 10.10.1.0/24)."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.pod_cidr)) && can(cidrsubnet(var.pod_cidr, 0, 0)) && try(cidrsubnet(var.pod_cidr, 0, 0) == var.pod_cidr, false)
    error_message = "pod_cidr must be a valid canonical IPv4 CIDR with no host bits set (e.g. 10.10.1.0/24, not 10.10.1.5/24)."
  }
}

variable "service_cidr" {
  description = "Secondary range for GKE Services (canonical IPv4 CIDR, e.g. 10.10.1.0/24)."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.service_cidr)) && can(cidrsubnet(var.service_cidr, 0, 0)) && try(cidrsubnet(var.service_cidr, 0, 0) == var.service_cidr, false)
    error_message = "service_cidr must be a valid canonical IPv4 CIDR with no host bits set (e.g. 10.10.1.0/24, not 10.10.1.5/24)."
  }
}
