module "secret_manager" {
  source = "../../modules/secret-manager"

  project_id = var.project_id

  # Create secret containers only.
  # Secret values will be supplied through a secure process later.
  secrets = [
    {
      name           = "kaveri-dev-app-config"
      create_version = false
    },
    {
      name           = "kaveri-dev-db-credentials"
      create_version = false
    }
  ]

  labels = merge(local.common_labels, { component = "secret-manager" })

  # Only the application runtime identity receives secret access.
  secret_accessors_list = [
    "serviceAccount:${module.service_accounts.service_account_emails["app-runtime"]}"
  ]

  # Default automatic replication; no CMEK key is configured yet.
  automatic_replication    = {}
  user_managed_replication = {}

  depends_on = [
    google_project_service.required,
    module.service_accounts
  ]
}
