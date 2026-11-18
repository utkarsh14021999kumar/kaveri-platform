terraform {
  required_version = ">= 1.5.0"

  backend "gcs" {
    bucket = "vibrant-chain-514216-p4-tfstate"
    prefix = "environments/dev"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "= 6.50.0"
    }
  }
}
