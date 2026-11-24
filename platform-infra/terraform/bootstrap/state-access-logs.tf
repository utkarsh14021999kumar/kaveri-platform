# Receives access logs for the Terraform state bucket (CKV_GCP_62).
resource "google_storage_bucket" "state_access_logs" {
  # checkov:skip=CKV_GCP_62:This bucket is the access-log sink; logging it to itself would recurse.
  project  = var.project_id
  name     = "${var.bucket_prefix}-tfstate-logs"
  location = var.location

  labels = merge(var.labels, { purpose = "tfstate-access-logs" })

  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true
  force_destroy               = false

  versioning {
    enabled = true
  }

  # Keep 90 days of access logs, then delete (cost control).
  lifecycle_rule {
    condition {
      age = 90
    }
    action {
      type = "Delete"
    }
  }
}

# Google-managed group that writes GCS access-log objects.
resource "google_storage_bucket_iam_member" "state_access_logs_writer" {
  bucket = google_storage_bucket.state_access_logs.name
  role   = "roles/storage.objectCreator"
  member = "group:cloud-storage-analytics@google.com"
}
