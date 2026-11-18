module "gke" {
  source = "../../modules/gke"

  project_id   = var.project_id
  cluster_name = "kaveri-dev-gke"
  region       = var.region

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

  # DEV uses one worker zone to limit compute costs.
  # The GKE control plane remains regional.
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
    }
  ]

  labels = {
    application = "kaveri"
    environment = "dev"
    managed_by  = "terraform"
    platform    = "gke"
  }

  depends_on = [
    google_project_service.required,
    module.networking,
    module.cloud_nat,
    module.iam,
    module.artifact_registry
  ]
}
