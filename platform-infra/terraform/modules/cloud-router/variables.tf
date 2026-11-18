variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "name" {
  description = "Cloud Router name"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "asia-south1"
}

variable "network" {
  description = "VPC network self-link or name"
  type        = string
}

variable "description" {
  description = "Cloud Router description"
  type        = string
  default     = "Corporate Cloud Router managed by Terraform"
}

variable "encrypted_interconnect_router" {
  description = "Whether this router is dedicated to encrypted Interconnect"
  type        = bool
  default     = false
}

variable "bgp" {
  description = "Optional BGP configuration"
  type = object({
    asn               = number
    advertise_mode    = optional(string, "CUSTOM")
    advertised_groups = optional(list(string), [])
    advertised_ip_ranges = optional(list(object({
      range       = string
      description = optional(string)
    })), [])
    keepalive_interval = optional(number)
  })
  default = null
}
