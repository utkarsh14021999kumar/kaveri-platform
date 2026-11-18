locals {
  artifact_registry_iam_members = merge(
    {
      for member in try(var.members.readers, []) :
      "reader-${sha256(member)}" => {
        role   = "roles/artifactregistry.reader"
        member = member
      }
    },
    {
      for member in try(var.members.writers, []) :
      "writer-${sha256(member)}" => {
        role   = "roles/artifactregistry.writer"
        member = member
      }
    }
  )
}

resource "google_artifact_registry_repository" "this" {
  project       = var.project_id
  location      = var.location
  repository_id = var.repository_id
  format        = var.format
  mode          = var.mode
  description   = var.description
  labels        = var.labels
  kms_key_name  = var.kms_key_name

  cleanup_policy_dry_run = var.cleanup_policy_dry_run

  dynamic "docker_config" {
    for_each = var.format == "DOCKER" ? [var.docker_config] : []

    content {
      immutable_tags = docker_config.value.immutable_tags
    }
  }

  dynamic "cleanup_policies" {
    for_each = var.cleanup_policies

    content {
      id     = cleanup_policies.key
      action = cleanup_policies.value.action

      dynamic "condition" {
        for_each = cleanup_policies.value.condition == null ? [] : [
          cleanup_policies.value.condition
        ]

        content {
          tag_state             = condition.value.tag_state
          tag_prefixes          = condition.value.tag_prefixes
          version_name_prefixes = condition.value.version_name_prefixes
          package_name_prefixes = condition.value.package_name_prefixes
          older_than            = condition.value.older_than
          newer_than            = condition.value.newer_than
        }
      }

      dynamic "most_recent_versions" {
        for_each = cleanup_policies.value.most_recent_versions == null ? [] : [
          cleanup_policies.value.most_recent_versions
        ]

        content {
          package_name_prefixes = most_recent_versions.value.package_name_prefixes
          keep_count            = most_recent_versions.value.keep_count
        }
      }
    }
  }

  lifecycle {
    precondition {
      condition     = var.enable_vpcsc_policy == false
      error_message = "VPC Service Controls is configured at the Access Context Manager service perimeter level, not on an Artifact Registry repository. Configure the perimeter separately."
    }
  }
}

resource "google_artifact_registry_repository_iam_member" "this" {
  for_each = local.artifact_registry_iam_members

  project    = google_artifact_registry_repository.this.project
  location   = google_artifact_registry_repository.this.location
  repository = google_artifact_registry_repository.this.repository_id
  role       = each.value.role
  member     = each.value.member
}
