# GCS Remote State Terraform Module

## Official module
terraform-google-modules/cloud-storage/google

## Module version
12.3.0

## Google provider
6.50.0

## Random provider
3.9.1

## Project
vibrant-chain-514216-p4

## Bucket
vibrant-chain-514216-p4-tfstate

## Location
ASIA-SOUTH1

## Features
- Google Cloud Storage bucket
- Uniform bucket-level access
- Public access prevention
- Object versioning
- force_destroy disabled
- Resource labels

## Purpose
Provides centralized remote Terraform state storage.

## Important
This module creates the bucket configuration only.
The GCS backend is configured separately in environment root modules.

No GCP resources are deployed by this module's initialization or validation.
