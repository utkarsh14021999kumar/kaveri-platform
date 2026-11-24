# State access: deployer reads/writes/locks; plan identity reads only (plans run with -lock=false).
resource "google_storage_bucket_iam_member" "deployer_state" {
  bucket = module.gcs_remote_state.bucket_name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.terraform_deployer.email}"
}

resource "google_storage_bucket_iam_member" "plan_state" {
  bucket = module.gcs_remote_state.bucket_name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.terraform_plan.email}"
}

# Deployer: least-privilege project roles (no owner/editor, no project-wide actAs).
resource "google_project_iam_member" "deployer" {
  # checkov:skip=CKV_GCP_49:Accepted risk with compensating controls - see docs/adr/0008-deployer-sa-admin-risk-acceptance.md.
  for_each = toset(var.deployer_project_roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.terraform_deployer.email}"
}

# Deployer may manage project IAM ONLY for the listed roles (delegated role grants).
resource "google_project_iam_member" "deployer_delegated_iam" {
  project = var.project_id
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = "serviceAccount:${google_service_account.terraform_deployer.email}"

  condition {
    title       = "kaveri-deployer-limited-grants"
    description = "Deployer may only grant or revoke the roles in deployer_grantable_roles."
    expression  = "api.getAttribute('iam.googleapis.com/modifiedGrantsByRole', []).hasOnly(${jsonencode(var.deployer_grantable_roles)})"
  }
}

# Plan identity: read-only.
resource "google_project_iam_member" "plan" {
  for_each = toset(var.plan_project_roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.terraform_plan.email}"
}
