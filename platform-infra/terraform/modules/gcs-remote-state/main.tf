resource "google_storage_bucket" "this" {
  project  = var.project_id
  name     = "${var.bucket_prefix}-${var.bucket_suffix}"
  location = var.location

  labels = var.labels

  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  force_destroy = false

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
