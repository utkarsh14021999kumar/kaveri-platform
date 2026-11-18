
terraform {
  required_version = ">= 1.3.0"

  backend "gcs" {
    bucket = "vibrant-chain-514216-p4-tfstate"
    prefix = "bootstrap"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "= 6.50.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "asia-south1"
}

