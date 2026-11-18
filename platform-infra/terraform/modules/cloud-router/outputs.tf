output "router_name" {
  description = "Cloud Router name"
  value       = google_compute_router.this.name
}

output "router_self_link" {
  description = "Cloud Router self-link"
  value       = google_compute_router.this.self_link
}

output "router_region" {
  description = "Cloud Router region"
  value       = google_compute_router.this.region
}

output "router_network" {
  description = "VPC network associated with the router"
  value       = google_compute_router.this.network
}

output "router_id" {
  description = "Cloud Router resource ID"
  value       = google_compute_router.this.id
}
