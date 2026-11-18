output "secret_names" {
  description = "Names of managed Secret Manager secrets"

  value = {
    for name, secret in google_secret_manager_secret.this :
    name => secret.id
  }
}

output "secret_versions" {
  description = "Names of managed Secret Manager versions"

  value = {
    for name, version in google_secret_manager_secret_version.this :
    name => version.name
  }
}
