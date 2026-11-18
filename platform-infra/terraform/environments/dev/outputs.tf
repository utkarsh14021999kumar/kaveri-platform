output "dev_project_id" {
  description = "GCP project hosting Kaveri DEV."
  value       = var.project_id
}

output "dev_region" {
  description = "Primary GCP region for Kaveri DEV."
  value       = var.region
}

output "dev_vpc_name" {
  description = "Kaveri DEV VPC name."
  value       = module.networking.network_name
}

output "dev_vpc_self_link" {
  description = "Kaveri DEV VPC self link."
  value       = module.networking.network_self_link
}

output "dev_subnet_name" {
  description = "Kaveri DEV subnet name."
  value       = module.networking.subnets_names[0]
}

output "dev_subnet_self_link" {
  description = "Kaveri DEV subnet self link."
  value       = module.networking.subnets_self_links[0]
}

output "dev_cloud_router_name" {
  description = "Kaveri DEV Cloud Router name."
  value       = module.cloud_router.router_name
}

output "dev_cloud_nat_name" {
  description = "Kaveri DEV Cloud NAT name."
  value       = module.cloud_nat.nat_name
}

output "dev_service_account_emails" {
  description = "Dedicated Kaveri DEV service account emails."
  value       = module.service_accounts.service_account_emails
}

output "dev_artifact_registry_repository_id" {
  description = "Kaveri DEV Docker Artifact Registry repository ID."
  value       = "kaveri-dev-docker"
}

output "dev_gke_cluster_name" {
  description = "Kaveri DEV GKE cluster name."
  value       = module.gke.cluster_name
}

output "dev_gke_location" {
  description = "Kaveri DEV GKE cluster location."
  value       = module.gke.cluster_location
}

output "dev_gke_workload_identity_pool" {
  description = "Workload Identity pool configured for Kaveri DEV GKE."
  value       = module.gke.workload_identity_pool
}

output "dev_gke_gateway_api_channel" {
  description = "GKE Gateway API channel."
  value       = module.gke.gateway_api_channel
}

output "dev_gke_node_pools" {
  description = "Kaveri DEV GKE node pool names."
  value       = module.gke.node_pool_names
}

output "dev_secret_names" {
  description = "Kaveri DEV Secret Manager secret resource names."
  value       = module.secret_manager.secret_names
}
