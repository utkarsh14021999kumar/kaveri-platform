module "cloud_nat" {
  source = "../../modules/cloud-nat"

  project_id = var.project_id
  region     = var.region
  name       = "kaveri-dev-nat"
  router     = module.cloud_router.router_name

  subnetworks = [
    {
      name = module.networking.subnets_self_links[0]

      source_ip_ranges_to_nat = [
        "PRIMARY_IP_RANGE",
        "LIST_OF_SECONDARY_IP_RANGES"
      ]

      secondary_ip_range_names = [
        "gke-pods"
      ]
    }
  ]

  nat_ips          = []
  drain_nat_ips    = []
  min_ports_per_vm = 64

  max_ports_per_vm               = null
  enable_dynamic_port_allocation = false

  log_config_enable = true
  log_config_filter = "ERRORS_ONLY"

  depends_on = [
    google_project_service.required,
    module.cloud_router,
    module.networking
  ]
}
