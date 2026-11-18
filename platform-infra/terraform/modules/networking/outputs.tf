output "network_name" {
  description = "Name of the created VPC network"
  value       = google_compute_network.this.name
}

output "network_id" {
  description = "ID of the created VPC network"
  value       = google_compute_network.this.id
}

output "network_self_link" {
  description = "Self-link of the created VPC network"
  value       = google_compute_network.this.self_link
}

output "project_id" {
  description = "GCP project ID associated with the VPC"
  value       = google_compute_network.this.project
}

output "subnets_names" {
  description = "Names of the created subnets"
  value       = [google_compute_subnetwork.this.name]
}

output "subnets_ids" {
  description = "IDs of the created subnets"
  value       = [google_compute_subnetwork.this.id]
}

output "subnets_ips" {
  description = "CIDR ranges of the created subnets"
  value       = [google_compute_subnetwork.this.ip_cidr_range]
}

output "subnets_self_links" {
  description = "Self-links of the created subnets"
  value       = [google_compute_subnetwork.this.self_link]
}

output "subnets_regions" {
  description = "Regions where the subnets are created"
  value       = [google_compute_subnetwork.this.region]
}

output "subnets_private_access" {
  description = "Private Google Access configuration"
  value       = [google_compute_subnetwork.this.private_ip_google_access]
}

output "subnets_flow_logs" {
  description = "VPC Flow Logs status"
  value       = [google_compute_subnetwork.this.log_config != null]
}

output "subnets_secondary_ranges" {
  description = "Secondary IP ranges for GKE Pods and Services"
  value = {
    (google_compute_subnetwork.this.name) = google_compute_subnetwork.this.secondary_ip_range
  }
}
