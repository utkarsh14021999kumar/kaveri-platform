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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | = 6.50.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.50.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.this](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/storage_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_prefix"></a> [bucket\_prefix](#input\_bucket\_prefix) | Prefix used to generate the state bucket name | `string` | `"vibrant-chain-514216-p4"` | no |
| <a name="input_bucket_suffix"></a> [bucket\_suffix](#input\_bucket\_suffix) | Suffix used to generate the state bucket name | `string` | `"tfstate"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels applied to the GCS state bucket | `map(string)` | <pre>{<br/>  "environment": "platform",<br/>  "managed_by": "terraform",<br/>  "purpose": "terraform-state"<br/>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | GCS bucket location | `string` | `"ASIA-SOUTH1"` | no |
| <a name="input_log_bucket"></a> [log\_bucket](#input\_log\_bucket) | Bucket that receives access logs for this bucket (CKV\_GCP\_62). Null disables access logging. | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID hosting the Terraform state bucket | `string` | `"vibrant-chain-514216-p4"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | Name of the Terraform remote state bucket |
| <a name="output_bucket_names"></a> [bucket\_names](#output\_bucket\_names) | List of generated bucket names |
| <a name="output_bucket_url"></a> [bucket\_url](#output\_bucket\_url) | URL of the Terraform remote state bucket |
| <a name="output_bucket_urls"></a> [bucket\_urls](#output\_bucket\_urls) | List of generated bucket URLs |
<!-- END_TF_DOCS -->
