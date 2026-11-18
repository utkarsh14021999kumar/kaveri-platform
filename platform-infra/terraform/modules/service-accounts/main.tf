locals {
  service_accounts = {
    for index, name in var.names : name => {
      account_id = substr(
        trimsuffix("${var.prefix}-${name}", "-"),
        0,
        30
      )
      description = length(var.descriptions) > index ? var.descriptions[index] : var.description
    }
  }

  project_role_assignments = {
    for item in flatten([
      for assignment in var.project_roles : [
        for name in var.names : {
          key        = "${name}|${assignment}"
          name       = name
          project_id = split("=>", assignment)[0]
          role       = split("=>", assignment)[1]
        }
      ] if length(split("=>", assignment)) == 2
    ]) : item.key => item
  }
}

resource "google_service_account" "this" {
  for_each = local.service_accounts

  project      = var.project_id
  account_id   = each.value.account_id
  display_name = var.display_name
  description  = each.value.description

  disabled = lookup(
    var.disabled,
    each.key,
    lookup(var.disabled, each.value.account_id, false)
  )
}

resource "google_project_iam_member" "roles" {
  for_each = local.project_role_assignments

  project = each.value.project_id
  role    = each.value.role

  member = "serviceAccount:${google_service_account.this[each.value.name].email}"
}

check "unique_service_account_names" {
  assert {
    condition = length(var.names) == length(distinct(var.names))

    error_message = "Service account names must be unique."
  }
}

check "valid_project_role_assignments" {
  assert {
    condition = alltrue([
      for assignment in var.project_roles :
      length(split("=>", assignment)) == 2 &&
      trimspace(split("=>", assignment)[0]) != "" &&
      startswith(trimspace(split("=>", assignment)[1]), "roles/")
    ])

    error_message = "Each project_roles entry must use project_id=>roles/role-name format."
  }
}
