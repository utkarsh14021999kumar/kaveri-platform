module "firewall" {
  source = "../../modules/firewall"

  project_id   = var.project_id
  network_name = module.networking.network_name

  # GKE manages its required cluster firewall rules.
  # Add custom ingress rules only for explicitly approved traffic.
  ingress_rules = []

  # Keep custom egress rules empty for the initial DEV baseline.
  # Egress restrictions will be designed after application dependencies
  # and required Google Cloud service endpoints are identified.
  egress_rules = []

  depends_on = [
    google_project_service.required,
    module.networking
  ]
}
