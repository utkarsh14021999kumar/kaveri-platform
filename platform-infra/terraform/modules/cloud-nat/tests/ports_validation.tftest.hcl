# Proves the NAT port validation rules: good input accepted, bad input rejected.
# mock_provider: no credentials, no API calls, no cost.
mock_provider "google" {}

variables {
  project_id = "test-project"
  region     = "asia-south1"
  name       = "test-nat"
  router     = "test-router"
}

run "default_ports_are_accepted" {
  command = plan
}

run "min_ports_below_range_is_rejected" {
  command = plan
  variables {
    min_ports_per_vm = 1
  }
  expect_failures = [var.min_ports_per_vm]
}

run "max_ports_not_power_of_two_is_rejected" {
  command = plan
  variables {
    max_ports_per_vm = 100
  }
  expect_failures = [var.max_ports_per_vm]
}

run "max_ports_power_of_two_is_accepted" {
  command = plan
  variables {
    max_ports_per_vm = 1024
  }
}
