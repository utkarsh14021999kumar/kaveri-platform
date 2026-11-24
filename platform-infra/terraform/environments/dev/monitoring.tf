resource "google_monitoring_alert_policy" "gke_node_cpu_high" {
  project      = var.project_id
  display_name = "Kaveri DEV - GKE Node CPU High"
  combiner     = "OR"

  conditions {
    display_name = "GKE node CPU utilization above 85 percent"

    condition_threshold {
      filter = join(" AND ", [
        "resource.type = \"k8s_node\"",
        "metric.type = \"kubernetes.io/node/cpu/allocatable_utilization\""
      ])

      comparison      = "COMPARISON_GT"
      threshold_value = 0.85
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }

      trigger {
        count = 1
      }
    }
  }

  documentation {
    mime_type = "text/markdown"
    content   = "Kaveri DEV GKE node CPU utilization has remained above 85% for five minutes. Review node and workload resource consumption."
  }

  user_labels = merge(local.common_labels, { component = "monitoring" })

  depends_on = [
    google_project_service.required,
    module.gke
  ]
}

resource "google_monitoring_alert_policy" "gke_node_memory_high" {
  project      = var.project_id
  display_name = "Kaveri DEV - GKE Node Memory High"
  combiner     = "OR"

  conditions {
    display_name = "GKE node memory utilization above 85 percent"

    condition_threshold {
      filter = join(" AND ", [
        "resource.type = \"k8s_node\"",
        "metric.type = \"kubernetes.io/node/memory/allocatable_utilization\""
      ])

      comparison      = "COMPARISON_GT"
      threshold_value = 0.85
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }

      trigger {
        count = 1
      }
    }
  }

  documentation {
    mime_type = "text/markdown"
    content   = "Kaveri DEV GKE node memory utilization has remained above 85% for five minutes. Review memory requests, limits and workload consumption."
  }

  user_labels = merge(local.common_labels, { component = "monitoring" })

  depends_on = [
    google_project_service.required,
    module.gke
  ]
}
