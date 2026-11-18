module "cloud_router" {
  source = "../../modules/cloud-router"

  project_id = var.project_id
  name       = "kaveri-dev-router"
  region     = var.region
  network    = module.networking.network_self_link

  description = "Cloud Router for Kaveri DEV private workloads"

  encrypted_interconnect_router = false

  depends_on = [
    google_project_service.required,
    module.networking
  ]
}
