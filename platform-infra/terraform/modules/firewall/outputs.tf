output "firewall_rules" {
  description = "Created firewall rule resources"

  value = merge(
    google_compute_firewall.ingress,
    google_compute_firewall.egress
  )
}

output "firewall_rules_ingress_egress" {
  description = "Created ingress and egress firewall rule resources"

  value = {
    ingress = google_compute_firewall.ingress
    egress  = google_compute_firewall.egress
  }
}
