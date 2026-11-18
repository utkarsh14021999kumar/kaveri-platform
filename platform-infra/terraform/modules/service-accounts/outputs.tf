output "service_account_emails" {
  description = "Service account email addresses indexed by name"

  value = {
    for name, account in google_service_account.this :
    name => account.email
  }
}

output "service_account_emails_list" {
  description = "List of service account email addresses"

  value = [
    for name in sort(keys(google_service_account.this)) :
    google_service_account.this[name].email
  ]
}

output "service_account_iam_emails" {
  description = "IAM-format service account email addresses indexed by name"

  value = {
    for name, account in google_service_account.this :
    name => "serviceAccount:${account.email}"
  }
}

output "service_account_iam_emails_list" {
  description = "List of IAM-format service account email addresses"

  value = [
    for name in sort(keys(google_service_account.this)) :
    "serviceAccount:${google_service_account.this[name].email}"
  ]
}

output "service_accounts_map" {
  description = "Created service account resources indexed by name"

  value = google_service_account.this
}
