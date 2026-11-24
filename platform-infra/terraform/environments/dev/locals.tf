locals {
  # Single source of truth for DEV cost/ownership labels (FinOps, ADR-0006).
  # Each component adds only its own "component" label on top of these.
  common_labels = merge(var.labels, {
    environment = var.environment
  })
}
