output "secret_names" {
  description = "Names of managed Secret Manager secrets"

  value = {
    for name, secret in google_secret_manager_secret.this :
    name => secret.id
  }
}

