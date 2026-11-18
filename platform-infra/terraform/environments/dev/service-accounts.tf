module "service_accounts" {
  source = "../../modules/service-accounts"

  project_id = var.project_id
  prefix     = "kaveri-dev"

  names = [
    "gke-node",
    "app-runtime"
  ]

  descriptions = [
    "Identity used by Kaveri DEV GKE worker nodes",
    "Identity reserved for Kaveri DEV application workloads"
  ]

  display_name = "Kaveri DEV Platform Identity"

  # Permissions are assigned separately through the IAM module.
  project_roles = []

  depends_on = [
    google_project_service.required
  ]
}
