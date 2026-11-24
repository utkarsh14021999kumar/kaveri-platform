# Remote state bucket (deployed in Phase 1 - address unchanged, so no recreation).
module "gcs_remote_state" {
  source = "../modules/gcs-remote-state"

  project_id    = var.project_id
  bucket_prefix = var.bucket_prefix
  bucket_suffix = var.bucket_suffix
  location      = var.location
  labels        = var.labels
  log_bucket    = google_storage_bucket.state_access_logs.name
}

# APIs required for Workload Identity Federation and IAM administration.
resource "google_project_service" "identity_apis" {
  for_each = toset([
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
  ])

  project                    = var.project_id
  service                    = each.value
  disable_on_destroy         = false
  disable_dependent_services = false
}
