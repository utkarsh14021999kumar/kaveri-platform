# Trust boundary for GitHub Actions.
resource "google_iam_workload_identity_pool" "github" {
  project                   = var.project_id
  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = "Kaveri GitHub Actions Pool"
  description               = "Federation pool for the kaveri-platform repository."
  disabled                  = false

  depends_on = [google_project_service.identity_apis]
}

# Accepts GitHub OIDC tokens only from the platform repository, matched by immutable IDs
# (names can be renamed or re-registered; numeric IDs cannot - prevents repo-jacking).
resource "google_iam_workload_identity_pool_provider" "github" {
  # checkov:skip=CKV_GCP_125:Condition pins immutable owner/repo IDs (stronger than name claims); see docs/incidents/2026-11-23-wif-deployer-403.md.
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_provider_id
  display_name                       = "Kaveri GitHub OIDC Provider"

  attribute_mapping = {
    "google.subject"                = "assertion.sub"
    "attribute.repository"          = "assertion.repository"
    "attribute.repository_owner"    = "assertion.repository_owner"
    "attribute.repository_id"       = "assertion.repository_id"
    "attribute.repository_owner_id" = "assertion.repository_owner_id"
    "attribute.ref"                 = "assertion.ref"
    "attribute.actor"               = "assertion.actor"
  }

  attribute_condition = "assertion.repository_owner_id == '${var.github_owner_id}' && assertion.repository_id == '${var.github_repository_id}'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}
