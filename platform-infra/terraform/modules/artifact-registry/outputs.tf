output "artifact_id" {
  description = "Unique Artifact Registry repository resource ID"
  value       = google_artifact_registry_repository.this.id
}

output "artifact_name" {
  description = "Artifact Registry repository name"
  value       = google_artifact_registry_repository.this.name
}

output "create_time" {
  description = "Repository creation timestamp"
  value       = google_artifact_registry_repository.this.create_time
}

output "update_time" {
  description = "Repository last update timestamp"
  value       = google_artifact_registry_repository.this.update_time
}
