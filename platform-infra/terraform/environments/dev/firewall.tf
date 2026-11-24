module "firewall" {
  source = "../../modules/firewall"

  project_id   = var.project_id
  network_name = module.networking.network_name

  # GKE manages its required cluster firewall rules.
  # Add custom ingress rules only for explicitly approved traffic.
  ingress_rules = [
    {
      # Explicit default-deny with logging (CKV2_GCP_18). Anything else needs a higher-priority allow.
      name          = "kaveri-dev-deny-all-ingress"
      description   = "Default deny for all ingress, logged"
      priority      = 65534
      source_ranges = ["0.0.0.0/0"]
      deny          = [{ protocol = "all" }]
      log_config    = { metadata = "INCLUDE_ALL_METADATA" }
    },
    {
      # Google load balancer health-check ranges (Gateway API in Phase 2).
      name                    = "kaveri-dev-allow-gcp-health-checks"
      description             = "Google LB health checks to GKE nodes"
      priority                = 1000
      source_ranges           = ["35.191.0.0/16", "130.211.0.0/22"]
      target_service_accounts = [module.service_accounts.service_account_emails["gke-node"]]
      allow                   = [{ protocol = "tcp" }]
      log_config              = { metadata = "EXCLUDE_ALL_METADATA" }
    },
    {
      # Break-glass SSH only via Identity-Aware Proxy (IAM-audited); nodes have no public IPs.
      name                    = "kaveri-dev-allow-iap-ssh"
      description             = "SSH from the IAP TCP forwarding range to GKE nodes"
      priority                = 1000
      source_ranges           = ["35.235.240.0/20"]
      target_service_accounts = [module.service_accounts.service_account_emails["gke-node"]]
      allow                   = [{ protocol = "tcp", ports = ["22"] }]
      log_config              = { metadata = "INCLUDE_ALL_METADATA" }
    }
  ]

  # Keep custom egress rules empty for the initial DEV baseline.
  # Egress restrictions will be designed after application dependencies
  # and required Google Cloud service endpoints are identified.
  egress_rules = []

  depends_on = [
    google_project_service.required,
    module.networking
  ]
}
