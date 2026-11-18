output "cluster_name" {
  description = "GKE cluster name"
  value       = google_container_cluster.this.name
}

output "cluster_id" {
  description = "GKE cluster ID"
  value       = google_container_cluster.this.id
}

output "cluster_endpoint" {
  description = "GKE Kubernetes API endpoint"
  value       = google_container_cluster.this.endpoint
}

output "cluster_ca_certificate" {
  description = "GKE cluster CA certificate"
  value       = google_container_cluster.this.master_auth[0].cluster_ca_certificate
  sensitive   = true
}

output "cluster_location" {
  description = "GKE cluster location"
  value       = google_container_cluster.this.location
}

output "workload_identity_pool" {
  description = "GKE Workload Identity pool"
  value       = google_container_cluster.this.workload_identity_config[0].workload_pool
}

output "gateway_api_channel" {
  description = "GKE Gateway API channel"
  value       = google_container_cluster.this.gateway_api_config[0].channel
}

output "node_pool_names" {
  description = "GKE node pool names"
  value       = [for pool in google_container_node_pool.this : pool.name]
}

output "node_pool_versions" {
  description = "GKE node pool versions"
  value       = [for pool in google_container_node_pool.this : pool.version]
}
