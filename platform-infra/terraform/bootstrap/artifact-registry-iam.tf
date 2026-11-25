# Writer on ONE repository for the CI image pusher (#72). The repository itself is managed in environments/dev.
# Non-authoritative (_iam_member): coexists with the gke-node reader binding managed in the DEV root.
resource "google_artifact_registry_repository_iam_member" "ci_image_pusher_writer" {
  project    = var.project_id
  location   = var.image_registry_location
  repository = var.image_registry_repository
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.ci_image_pusher.email}"
}
