resource "google_compute_network" "this" {
  # checkov:skip=CKV2_GCP_18:Firewall rules live in modules/firewall and attach by network name (cross-module reference the graph check cannot follow). Default-deny + allows verified in the pipeline plan (#19).
  project                 = var.project_id
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
  description             = "Custom VPC managed by Terraform"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_subnetwork" "this" {
  project                  = var.project_id
  name                     = var.subnet_name
  region                   = var.region
  network                  = google_compute_network.this.id
  ip_cidr_range            = var.subnet_cidr
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = var.pod_cidr
  }

  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = var.service_cidr
  }

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

  lifecycle {
    prevent_destroy = true
  }
}
