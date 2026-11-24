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

  # Access logs: who read/wrote Terraform state, and when (CKV_GCP_62).
  dynamic "logging" {
    for_each = var.log_bucket == null ? [] : [var.log_bucket]
    content {
      log_bucket        = logging.value
      log_object_prefix = "tfstate-access/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
