output "nat_name" {
  description = "Name of the Cloud NAT."
  value       = google_compute_router_nat.this.name
}

output "nat_region" {
  description = "Region of the Cloud NAT."
  value       = google_compute_router_nat.this.region
}

output "nat_router_name" {
  description = "Cloud Router associated with the NAT."
  value       = google_compute_router_nat.this.router
}

output "nat_ip_allocate_option" {
  description = "NAT IP allocation mode."
  value       = google_compute_router_nat.this.nat_ip_allocate_option
}

output "nat_id" {
  description = "Cloud NAT resource ID."
  value       = google_compute_router_nat.this.id
}
