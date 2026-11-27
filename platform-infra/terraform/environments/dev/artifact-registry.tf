module "artifact_registry" {
  source = "../../modules/artifact-registry"

  project_id    = var.project_id
  location      = var.region
  repository_id = "kaveri-dev-docker"
  format        = "DOCKER"
  mode          = "STANDARD_REPOSITORY"

  description = "Private Docker repository for Kaveri DEV microservices"

  labels = merge(local.common_labels, { component = "artifact-registry" })

  docker_config = {
    immutable_tags = true
  }

  cleanup_policy_dry_run = true

  # 2.14: KEEP wins over DELETE. Dry run first; enforce after reviewing at least one daily cycle.
  cleanup_policies = {
    "keep-last-10" = {
      action               = "KEEP"
      most_recent_versions = { keep_count = 10 }
    }
    "delete-untagged-7d" = {
      action    = "DELETE"
      condition = { tag_state = "UNTAGGED", older_than = "604800s" }
    }
    "delete-tagged-90d" = {
      action    = "DELETE"
      condition = { tag_state = "TAGGED", older_than = "7776000s" }
    }
  }

  # GKE nodes can pull images but cannot publish or delete them.
  members = {
    readers = [
      module.service_accounts.service_account_iam_emails["gke-node"]
    ]
  }

  enable_vpcsc_policy = false

  depends_on = [
    google_project_service.required,
    module.service_accounts
  ]
}
