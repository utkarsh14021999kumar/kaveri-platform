
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
  description = "Minimum NAT ports per VM (whole number, 2-65536)."
  type        = number
  default     = 64

  validation {
    condition     = var.min_ports_per_vm >= 2 && var.min_ports_per_vm <= 65536 && floor(var.min_ports_per_vm) == var.min_ports_per_vm
    error_message = "min_ports_per_vm must be a whole number between 2 and 65536."
  }
}

variable "max_ports_per_vm" {
  description = "Maximum NAT ports per VM, used only with dynamic port allocation (null or a power of two, 64-65536)."
  type        = number
  default     = null

  validation {
    condition     = var.max_ports_per_vm == null ? true : contains([for i in range(6, 17) : pow(2, i)], var.max_ports_per_vm)
    error_message = "max_ports_per_vm must be null or a power of two between 64 and 65536."
  }
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

