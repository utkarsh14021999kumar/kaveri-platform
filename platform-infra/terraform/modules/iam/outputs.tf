output "projects" {
  description = "Projects that received IAM bindings"
  value       = var.projects
}

output "roles" {
  description = "IAM roles assigned to project members"
  value = distinct(concat(
    keys(var.bindings),
    [for binding in var.conditional_bindings : binding.role]
  ))
}

output "members" {
  description = "Members granted project IAM access"
  value = distinct(flatten(concat(
    values(var.bindings),
    [for binding in var.conditional_bindings : binding.members]
  )))
}
