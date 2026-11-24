variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "vibrant-chain-514216-p4"
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
  default     = "gke-dev"
}

variable "region" {
  description = "GKE regional location"
  type        = string
  default     = "asia-south1"
}

variable "network" {
  description = "Existing VPC network name"
  type        = string
}

variable "subnetwork" {
  description = "Existing subnet name"
  type        = string
}

variable "ip_range_pods" {
  description = "Existing secondary Pod IP range name"
  type        = string
}

variable "ip_range_services" {
  description = "Existing secondary Service IP range name"
  type        = string
}

variable "master_ipv4_cidr_block" {
  description = "Non-overlapping /28 control-plane CIDR"
  type        = string
  default     = "172.16.0.0/28"
}

variable "master_authorized_networks" {
  description = "Authorized control-plane access CIDRs"
  type = list(object({
    cidr_block   = string
    display_name = string
  }))
  default = []
}

variable "node_pools" {
  description = "GKE node pool configurations"

  type = list(object({
    name               = string
    machine_type       = string
    node_locations     = string
    min_count          = number
    max_count          = number
    initial_node_count = number
    disk_size_gb       = number
    disk_type          = string
    image_type         = string
    auto_repair        = bool
    auto_upgrade       = bool
  }))

  default = [
    {
      name               = "system-pool"
      machine_type       = "e2-medium"
      node_locations     = "asia-south1-a,asia-south1-b,asia-south1-c"
      min_count          = 1
      max_count          = 2
      initial_node_count = 1
      disk_size_gb       = 50
      disk_type          = "pd-balanced"
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
    }
  ]
}

variable "labels" {
  description = "GKE resource labels"
  type        = map(string)

  default = {
    managed_by  = "terraform"
    environment = "dev"
    platform    = "gke"
  }
}


variable "node_service_account_email" {
  description = "Dedicated service account attached to GKE worker nodes"
  type        = string
}

variable "enable_private_endpoint" {
  description = "Disable public access to the GKE Kubernetes control-plane endpoint"
  type        = bool
  default     = true
}

variable "location" {
  description = "Cluster location: a zone (zonal cluster, e.g. asia-south1-a) or a region (regional cluster). Defaults to var.region."
  type        = string
  default     = null
}

variable "enable_dns_endpoint" {
  description = "Expose the control plane through the IAM-controlled DNS-based endpoint (no public IP, no authorized networks)."
  type        = bool
  default     = false
}
