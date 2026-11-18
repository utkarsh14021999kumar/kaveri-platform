resource "google_service_account_iam_member" "app_runtime_workload_identity" {
  service_account_id = (
    "projects/${var.project_id}/serviceAccounts/${module.service_accounts.service_account_emails["app-runtime"]}"
  )

  role = "roles/iam.workloadIdentityUser"

  member = (
    "serviceAccount:${var.project_id}.svc.id.goog[kaveri-dev/app-runtime]"
  )

  depends_on = [
    module.gke,
    module.service_accounts
  ]
}
