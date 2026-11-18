module "artifact_registry" {
  source = "../../modules/artifact-registry"

  project_id    = var.project_id
  location      = var.region
  repository_id = "kaveri-dev-docker"
  format        = "DOCKER"
  mode          = "STANDARD_REPOSITORY"

  description = "Private Docker repository for Kaveri DEV microservices"

  labels = {
    application = "kaveri"
    environment = "dev"
    managed_by  = "terraform"
  }

  docker_config = {
    immutable_tags = true
  }

  cleanup_policy_dry_run = true

  cleanup_policies = {}

  # GKE nodes can pull images but cannot publish or delete them.
  members = {
    readers = [
      module.service_accounts.service_account_iam_emails["gke-node"]
    ]
  }

  enable_vpcsc_policy = false

  depends_on = [
    google_project_service.required,
    module.service_accounts
  ]
}
