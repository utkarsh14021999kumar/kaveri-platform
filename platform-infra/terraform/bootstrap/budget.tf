# Phase 1 step 17: budget alerts at INR 500 / 1000 / 2000 (25/50/100% of 2000) + 100% forecast.
provider "google" {
  alias                 = "billing"
  project               = var.project_id
  billing_project       = var.project_id
  user_project_override = true
}

resource "google_project_service" "budget_apis" {
  for_each           = toset(["billingbudgets.googleapis.com", "monitoring.googleapis.com"])
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}

data "google_project" "budget" {
  project_id = var.project_id
}

resource "google_monitoring_notification_channel" "budget_email" {
  project      = var.project_id
  display_name = "KAVERI budget alerts"
  type         = "email"
  labels       = { email_address = var.budget_alert_email }
  depends_on   = [google_project_service.budget_apis]
}

resource "google_billing_budget" "kaveri" {
  provider        = google.billing
  billing_account = var.billing_account_id
  display_name    = "kaveri-${var.project_id}-monthly"

  budget_filter {
    projects        = ["projects/${data.google_project.budget.number}"]
    calendar_period = "MONTH"
  }

  amount {
    specified_amount {
      currency_code = "INR"
      units         = tostring(var.budget_amount_inr)
    }
  }

  dynamic "threshold_rules" {
    for_each = [0.25, 0.5, 1.0]
    content {
      threshold_percent = threshold_rules.value
    }
  }

  threshold_rules {
    threshold_percent = 1.0
    spend_basis       = "FORECASTED_SPEND"
  }

  all_updates_rule {
    monitoring_notification_channels = [google_monitoring_notification_channel.budget_email.id]
    disable_default_iam_recipients   = false
  }

  depends_on = [google_project_service.budget_apis]
}
