# Proves the CIDR validation rules: good input accepted, bad input rejected.
# mock_provider: no credentials, no API calls, no cost.
mock_provider "google" {}

variables {
  project_id   = "test-project"
  region       = "asia-south1"
  network_name = "test-vpc"
  subnet_name  = "test-subnet"
  subnet_cidr  = "10.10.1.0/24"
  pod_cidr     = "10.20.0.0/16"
  service_cidr = "10.30.0.0/20"
}

run "valid_cidrs_are_accepted" {
  command = plan
}

run "non_canonical_subnet_is_rejected" {
  command = plan
  variables {
    subnet_cidr = "10.10.1.5/24"
  }
  expect_failures = [var.subnet_cidr]
}

run "garbage_pod_range_is_rejected" {
  command = plan
  variables {
    pod_cidr = "not-a-cidr"
  }
  expect_failures = [var.pod_cidr]
}

run "non_canonical_service_range_is_rejected" {
  command = plan
  variables {
    service_cidr = "10.30.0.1/20"
  }
  expect_failures = [var.service_cidr]
}
