
variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "asia-south1"
}

variable "name" {
  description = "Cloud NAT name"
  type        = string
  default     = "corporate-cloud-nat"
}

variable "router" {
  description = "Existing Cloud Router name"
  type        = string
}

variable "subnetworks" {
  description = "Subnetwork and secondary IP ranges requiring NAT"
  type = list(object({
    name                     = string
    source_ip_ranges_to_nat  = list(string)
    secondary_ip_range_names = list(string)
  }))
  default = []
}

variable "nat_ips" {
  description = "Static external IP self-links; empty list enables automatic allocation"
  type        = list(string)
  default     = []
}

variable "drain_nat_ips" {
  description = "NAT IP addresses to drain"
  type        = list(string)
  default     = []
}

variable "min_ports_per_vm" {
  description = "Minimum NAT ports allocated per VM"
  type        = string
  default     = "64"
}

variable "max_ports_per_vm" {
  description = "Maximum NAT ports per VM when dynamic allocation is enabled"
  type        = string
  default     = null
  nullable    = true
}

variable "enable_dynamic_port_allocation" {
  description = "Enable dynamic NAT port allocation"
  type        = bool
  default     = false
}

variable "log_config_enable" {
  description = "Enable Cloud NAT logging"
  type        = bool
  default     = true
}

variable "log_config_filter" {
  description = "Cloud NAT logging filter"
  type        = string
  default     = "ERRORS_ONLY"

  validation {
    condition = contains(
      ["ERRORS_ONLY", "TRANSLATIONS_ONLY", "ALL"],
      var.log_config_filter
    )
    error_message = "Use ERRORS_ONLY, TRANSLATIONS_ONLY, or ALL."
  }
}

