resource "google_compute_router" "this" {
  project                       = var.project_id
  name                          = var.name
  region                        = var.region
  network                       = var.network
  description                   = var.description
  encrypted_interconnect_router = var.encrypted_interconnect_router

  dynamic "bgp" {
    for_each = var.bgp == null ? [] : [var.bgp]

    content {
      asn                = bgp.value.asn
      advertise_mode     = bgp.value.advertise_mode
      advertised_groups  = bgp.value.advertised_groups
      keepalive_interval = bgp.value.keepalive_interval

      dynamic "advertised_ip_ranges" {
        for_each = bgp.value.advertised_ip_ranges

        content {
          range       = advertised_ip_ranges.value.range
          description = advertised_ip_ranges.value.description
        }
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
