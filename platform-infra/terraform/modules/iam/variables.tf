
variable "projects" {
  description = "GCP project IDs where IAM bindings will be managed"
  type        = list(string)
  default     = []
}

variable "mode" {
  description = "IAM management mode: additive or authoritative"
  type        = string
  default     = "additive"

  validation {
    condition     = contains(["additive", "authoritative"], var.mode)
    error_message = "Mode must be either additive or authoritative."
  }
}

variable "bindings" {
  description = "Map of IAM roles to lists of members"
  type        = map(list(string))
  default     = {}
}

variable "conditional_bindings" {
  description = "IAM role bindings with IAM conditions"

  type = list(object({
    role        = string
    title       = string
    description = string
    expression  = string
    members     = list(string)
  }))

  default = []
}

