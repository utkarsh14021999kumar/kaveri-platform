module "gke" {
  source = "../../modules/gke"

  project_id   = var.project_id
  cluster_name = "kaveri-dev-gke"
  region       = var.region
  location     = var.zone

  # CI reaches the private control plane through the IAM-controlled DNS endpoint.
  enable_dns_endpoint = true

  network    = module.networking.network_name
  subnetwork = module.networking.subnets_names[0]

  ip_range_pods     = "gke-pods"
  ip_range_services = "gke-services"

  master_ipv4_cidr_block = var.master_ipv4_cidr_block

  # Private endpoint: Kubernetes API access must originate
  # from an authorized network inside the VPC.
  enable_private_endpoint    = true
  master_authorized_networks = []

  node_service_account_email = (
    module.service_accounts.service_account_emails["gke-node"]
  )

  # Zonal cluster (ADR-0006): control plane and nodes in var.zone.
  node_pools = [
    {
      name               = "kaveri-dev-system-pool"
      machine_type       = "e2-medium"
      node_locations     = "asia-south1-a"
      min_count          = 1
      max_count          = 2
      initial_node_count = 1
      disk_size_gb       = 50
      disk_type          = "pd-balanced"
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
    },
    {
      # ADR-0013: application workloads; Spot for DEV cost. P5-safe (new pool, no replacement).
      name               = "kaveri-dev-app-pool"
      machine_type       = "e2-standard-2"
      node_locations     = "asia-south1-a"
      min_count          = 1
      max_count          = 2
      initial_node_count = 1
      disk_size_gb       = 50
      disk_type          = "pd-balanced"
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
      spot               = true
    }
  ]

  labels = merge(local.common_labels, { component = "gke" })

  depends_on = [
    google_project_service.required,
    module.networking,
    module.cloud_nat,
    module.iam,
    module.artifact_registry,
    google_service_account_iam_member.deployer_acts_as_node_sa
  ]
}
