locals {
  additive_members = {
    for item in flatten([
      for project in var.projects : [
        for role, members in var.bindings : [
          for member in members : {
            key     = "${project}|${role}|${member}"
            project = project
            role    = role
            member  = member
          }
        ]
      ]
    ]) : item.key => item
  }

  authoritative_bindings = {
    for item in flatten([
      for project in var.projects : [
        for role, members in var.bindings : [{
          key     = "${project}|${role}"
          project = project
          role    = role
          members = toset(members)
        }]
      ]
    ]) : item.key => item
  }

  conditional_members = {
    for item in flatten([
      for project in var.projects : [
        for index, binding in var.conditional_bindings : [
          for member in binding.members : {
            key         = "${project}|${index}|${member}"
            project     = project
            role        = binding.role
            member      = member
            title       = binding.title
            description = binding.description
            expression  = binding.expression
          }
        ]
      ]
    ]) : item.key => item
  }
}

resource "google_project_iam_member" "additive" {
  for_each = var.mode == "additive" ? local.additive_members : {}

  project = each.value.project
  role    = each.value.role
  member  = each.value.member
}

resource "google_project_iam_binding" "authoritative" {
  for_each = var.mode == "authoritative" ? local.authoritative_bindings : {}

  project = each.value.project
  role    = each.value.role
  members = each.value.members
}

resource "google_project_iam_member" "conditional" {
  for_each = local.conditional_members

  project = each.value.project
  role    = each.value.role
  member  = each.value.member

  condition {
    title       = each.value.title
    description = each.value.description
    expression  = each.value.expression
  }
}
