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
