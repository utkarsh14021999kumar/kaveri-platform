locals {
  ingress_rules = {
    for rule in var.ingress_rules : rule.name => rule
  }

  egress_rules = {
    for rule in var.egress_rules : rule.name => rule
  }
}

resource "google_compute_firewall" "ingress" {
  for_each = local.ingress_rules

  project                 = var.project_id
  name                    = each.value.name
  description             = each.value.description
  network                 = var.network_name
  direction               = "INGRESS"
  priority                = each.value.priority
  disabled                = each.value.disabled
  destination_ranges      = each.value.destination_ranges
  source_ranges           = each.value.source_ranges
  source_tags             = each.value.source_tags
  source_service_accounts = each.value.source_service_accounts
  target_tags             = each.value.target_tags
  target_service_accounts = each.value.target_service_accounts

  dynamic "allow" {
    for_each = each.value.allow

    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  dynamic "deny" {
    for_each = each.value.deny

    content {
      protocol = deny.value.protocol
      ports    = deny.value.ports
    }
  }

  dynamic "log_config" {
    for_each = each.value.log_config == null ? [] : [each.value.log_config]

    content {
      metadata = log_config.value.metadata
    }
  }
}

resource "google_compute_firewall" "egress" {
  for_each = local.egress_rules

  project                 = var.project_id
  name                    = each.value.name
  description             = each.value.description
  network                 = var.network_name
  direction               = "EGRESS"
  priority                = each.value.priority
  disabled                = each.value.disabled
  destination_ranges      = each.value.destination_ranges
  source_ranges           = each.value.source_ranges
  source_tags             = each.value.source_tags
  source_service_accounts = each.value.source_service_accounts
  target_tags             = each.value.target_tags
  target_service_accounts = each.value.target_service_accounts

  dynamic "allow" {
    for_each = each.value.allow

    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  dynamic "deny" {
    for_each = each.value.deny

    content {
      protocol = deny.value.protocol
      ports    = deny.value.ports
    }
  }

  dynamic "log_config" {
    for_each = each.value.log_config == null ? [] : [each.value.log_config]

    content {
      metadata = log_config.value.metadata
    }
  }
}

check "unique_firewall_rule_names" {
  assert {
    condition = length(distinct(concat(
      keys(local.ingress_rules),
      keys(local.egress_rules)
    ))) == length(local.ingress_rules) + length(local.egress_rules)

    error_message = "Firewall rule names must be unique across ingress and egress."
  }
}
