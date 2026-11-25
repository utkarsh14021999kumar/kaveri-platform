resource "google_container_cluster" "this" {
  # checkov:skip=CKV_GCP_65:No Google Workspace or Cloud Identity org; access controlled via IAM (single-operator platform).
  # checkov:skip=CKV_GCP_21:Labels are set via resource_labels = var.labels (callers pass merge(local.common_labels,...)); static scanner cannot evaluate merge(). Verified in plan (#16).
  project  = var.project_id
  name     = var.cluster_name
  location = local.location

  network    = var.network
  subnetwork = var.subnetwork

  networking_mode = "VPC_NATIVE"

  # Pod-to-pod traffic on the same node is visible to VPC flow logs (CKV_GCP_61).
  enable_intranode_visibility = true

  # Legacy static client certificates disabled; API access is IAM-only (CKV_GCP_13).
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  remove_default_node_pool = true
  initial_node_count       = 1

  # The temporary default pool (removed right after creation) must use the dedicated
  # node SA - never the Compute Engine default SA - with the same hardening as real pools.
  node_config {
    service_account = var.node_service_account_email
    image_type      = "COS_CONTAINERD"
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  # IAM-controlled DNS endpoint for the control plane (no public IP, no authorized networks).
  dynamic "control_plane_endpoints_config" {
    for_each = var.enable_dns_endpoint ? [1] : []
    content {
      dns_endpoint_config {
        allow_external_traffic = true
      }
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.ip_range_pods
    services_secondary_range_name = var.ip_range_services
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = var.enable_private_endpoint
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  dynamic "master_authorized_networks_config" {
    # GKE API requires MAN enabled when the private endpoint is on (empty list = VPC-internal only; DNS endpoint uses IAM).
    for_each = (length(var.master_authorized_networks) > 0 || var.enable_private_endpoint) ? [1] : []

    content {
      dynamic "cidr_blocks" {
        for_each = var.master_authorized_networks

        content {
          cidr_block   = cidr_blocks.value.cidr_block
          display_name = cidr_blocks.value.display_name
        }
      }
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  enable_shielded_nodes = true
  deletion_protection   = true

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }

    http_load_balancing {
      disabled = false
    }

    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
  }

  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"

  resource_labels = var.labels

  lifecycle {
    prevent_destroy = true
    # The default pool is removed after creation; ignore its node_config afterwards.
    ignore_changes = [node_config]
  }
}

resource "google_container_node_pool" "this" {
  for_each = { for pool in var.node_pools : pool.name => pool }

  project  = var.project_id
  name     = each.value.name
  location = local.location
  cluster  = google_container_cluster.this.name

  node_locations = split(",", each.value.node_locations)

  initial_node_count = each.value.initial_node_count

  # initial_node_count is creation-only; GKE reports 0 after a pause (resize to 0) -> would force replacement (#61, P2-10).
  lifecycle {
    ignore_changes = [initial_node_count]
  }

  autoscaling {
    min_node_count = each.value.min_count
    max_node_count = each.value.max_count
  }

  management {
    auto_repair  = each.value.auto_repair
    auto_upgrade = each.value.auto_upgrade
  }

  node_config {
    machine_type    = each.value.machine_type
    disk_size_gb    = each.value.disk_size_gb
    disk_type       = each.value.disk_type
    image_type      = each.value.image_type
    service_account = var.node_service_account_email

    # Pods get only their own Workload Identity, never the node's credentials (CKV_GCP_69).
    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    labels = var.labels
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }
}
