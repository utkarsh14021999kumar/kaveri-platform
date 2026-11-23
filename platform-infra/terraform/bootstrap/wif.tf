# Trust boundary for GitHub Actions.
resource "google_iam_workload_identity_pool" "github" {
  project                   = var.project_id
  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = "Kaveri GitHub Actions Pool"
  description               = "Federation pool for the kaveri-platform repository."
  disabled                  = false

  depends_on = [google_project_service.identity_apis]
}

# Accepts GitHub OIDC tokens only from the platform repository.
# Finer rules (plan vs deploy) are enforced by the service account bindings.
resource "google_iam_workload_identity_pool_provider" "github" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_provider_id
  display_name                       = "Kaveri GitHub OIDC Provider"

  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
    "attribute.ref"              = "assertion.ref"
    "attribute.actor"            = "assertion.actor"
  }

  attribute_condition = "assertion.repository_owner == '${var.github_owner}' && assertion.repository == '${var.github_owner}/${var.github_repository}'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}
