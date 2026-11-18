resource "google_compute_router_nat" "this" {
  project = var.project_id
  name    = var.name
  region  = var.region
  router  = var.router

  nat_ip_allocate_option = length(var.nat_ips) > 0 ? "MANUAL_ONLY" : "AUTO_ONLY"
  nat_ips                = length(var.nat_ips) > 0 ? var.nat_ips : null
  drain_nat_ips          = length(var.nat_ips) > 0 ? var.drain_nat_ips : null

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  dynamic "subnetwork" {
    for_each = var.subnetworks

    content {
      name                    = subnetwork.value.name
      source_ip_ranges_to_nat = subnetwork.value.source_ip_ranges_to_nat
      secondary_ip_range_names = (
        contains(subnetwork.value.source_ip_ranges_to_nat, "LIST_OF_SECONDARY_IP_RANGES")
        ? subnetwork.value.secondary_ip_range_names
        : null
      )
    }
  }

  min_ports_per_vm               = var.min_ports_per_vm
  enable_dynamic_port_allocation = var.enable_dynamic_port_allocation
  max_ports_per_vm               = var.enable_dynamic_port_allocation ? var.max_ports_per_vm : null

  log_config {
    enable = var.log_config_enable
    filter = var.log_config_filter
  }

  lifecycle {
    prevent_destroy = true
  }
}
