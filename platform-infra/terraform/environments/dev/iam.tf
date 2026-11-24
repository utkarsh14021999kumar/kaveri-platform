module "iam" {
  source = "../../modules/iam"

  projects = [
    var.project_id
  ]

  mode = "additive"

  bindings = {
    "roles/container.defaultNodeServiceAccount" = [
      module.service_accounts.service_account_iam_emails["gke-node"]
    ]
  }

  conditional_bindings = []

  depends_on = [
    module.service_accounts,
    google_project_service.required
  ]
}

# GKE node pool creation requires the deployer to "act as" the node SA.
# Granted on this single service account only - never project-wide.
resource "google_service_account_iam_member" "deployer_acts_as_node_sa" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${module.service_accounts.service_account_emails["gke-node"]}"
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${var.deployer_service_account_email}"
}
