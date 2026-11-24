module "secret_manager" {
  source = "../../modules/secret-manager"

  project_id = var.project_id

  # Create secret containers only.
  # Secret values will be supplied through a secure process later.
  secrets = [
    {
      name = "kaveri-dev-app-config"
    },
    {
      name = "kaveri-dev-db-credentials"
    }
  ]

  labels = {
    "kaveri-dev-app-config"     = merge(local.common_labels, { component = "secret-manager", purpose = "application-config" })
    "kaveri-dev-db-credentials" = merge(local.common_labels, { component = "secret-manager", purpose = "database-credentials" })
  }

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
