data "google_project" "current" {
  project_id = var.project_id
}

locals {
  secrets_by_name = {
    for secret in var.secrets :
    secret.name => secret
  }

  secret_accessor_bindings = {
    for item in flatten([
      for secret_name in keys(local.secrets_by_name) : [
        for member in var.secret_accessors_list : {
          key         = "${secret_name}|${member}"
          secret_name = secret_name
          member      = member
        }
      ]
    ]) : item.key => item
  }

  kms_key_bindings = {
    for key_name in var.add_kms_permissions :
    key_name => key_name
  }

  pubsub_topic_bindings = {
    for topic_name in var.add_pubsub_permissions :
    topic_name => topic_name
  }
}

resource "google_secret_manager_secret" "this" {
  for_each = local.secrets_by_name

  project   = var.project_id
  secret_id = each.key
  labels    = lookup(var.labels, each.key, {})

  replication {
    dynamic "auto" {
      for_each = contains(
        keys(var.user_managed_replication),
        each.key
      ) ? [] : [1]

      content {
        dynamic "customer_managed_encryption" {
          for_each = try(
            var.automatic_replication[each.key].kms_key_name,
            null
          ) == null ? [] : [var.automatic_replication[each.key].kms_key_name]

          content {
            kms_key_name = customer_managed_encryption.value
          }
        }
      }
    }

    dynamic "user_managed" {
      for_each = contains(
        keys(var.user_managed_replication),
        each.key
      ) ? [1] : []

      content {
        dynamic "replicas" {
          for_each = var.user_managed_replication[each.key]

          content {
            location = replicas.value.location

            dynamic "customer_managed_encryption" {
              for_each = replicas.value.kms_key_name == null ? [] : [
                replicas.value.kms_key_name
              ]

              content {
                kms_key_name = customer_managed_encryption.value
              }
            }
          }
        }
      }
    }
  }

  dynamic "rotation" {
    for_each = each.value.rotation_period == null ? [] : [each.value]

    content {
      rotation_period    = rotation.value.rotation_period
      next_rotation_time = rotation.value.next_rotation_time
    }
  }

  dynamic "topics" {
    for_each = lookup(var.topics, each.key, [])

    content {
      name = topics.value.name
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}


resource "google_secret_manager_secret_iam_member" "accessor" {
  for_each = local.secret_accessor_bindings

  project   = var.project_id
  secret_id = google_secret_manager_secret.this[each.value.secret_name].secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = each.value.member
}

resource "google_kms_crypto_key_iam_member" "secret_manager" {
  for_each = local.kms_key_bindings

  crypto_key_id = each.value
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.current.number}@gcp-sa-secretmanager.iam.gserviceaccount.com"
}

resource "google_pubsub_topic_iam_member" "secret_manager" {
  for_each = local.pubsub_topic_bindings

  project = var.project_id
  topic   = each.value
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:service-${data.google_project.current.number}@gcp-sa-secretmanager.iam.gserviceaccount.com"
}
