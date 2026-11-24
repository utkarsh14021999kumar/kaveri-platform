# artifact-registry module


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | = 6.50.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | = 6.50.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_artifact_registry_repository.this](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/artifact_registry_repository) | resource |
| [google_artifact_registry_repository_iam_member.this](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/artifact_registry_repository_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cleanup_policies"></a> [cleanup\_policies](#input\_cleanup\_policies) | Artifact Registry cleanup policies | <pre>map(object({<br/>    action = optional(string)<br/>    condition = optional(object({<br/>      tag_state             = optional(string)<br/>      tag_prefixes          = optional(list(string))<br/>      version_name_prefixes = optional(list(string))<br/>      package_name_prefixes = optional(list(string))<br/>      older_than            = optional(string)<br/>      newer_than            = optional(string)<br/>    }), null)<br/>    most_recent_versions = optional(object({<br/>      package_name_prefixes = optional(list(string))<br/>      keep_count            = optional(number)<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_cleanup_policy_dry_run"></a> [cleanup\_policy\_dry\_run](#input\_cleanup\_policy\_dry\_run) | Run cleanup policies in dry-run mode | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Repository description | `string` | `"Corporate microservices Docker image repository"` | no |
| <a name="input_docker_config"></a> [docker\_config](#input\_docker\_config) | Docker repository configuration | <pre>object({<br/>    immutable_tags = optional(bool)<br/>  })</pre> | <pre>{<br/>  "immutable_tags": true<br/>}</pre> | no |
| <a name="input_enable_vpcsc_policy"></a> [enable\_vpcsc\_policy](#input\_enable\_vpcsc\_policy) | Enable VPC Service Controls policy | `bool` | `false` | no |
| <a name="input_format"></a> [format](#input\_format) | Artifact package format | `string` | `"DOCKER"` | no |
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | Optional Cloud KMS encryption key | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels assigned to the repository | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Artifact Registry region | `string` | `"asia-south1"` | no |
| <a name="input_members"></a> [members](#input\_members) | Artifact Registry reader and writer IAM members | `map(list(string))` | `{}` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | Repository mode | `string` | `"STANDARD_REPOSITORY"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_repository_id"></a> [repository\_id](#input\_repository\_id) | Artifact Registry repository name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_artifact_id"></a> [artifact\_id](#output\_artifact\_id) | Unique Artifact Registry repository resource ID |
| <a name="output_artifact_name"></a> [artifact\_name](#output\_artifact\_name) | Artifact Registry repository name |
| <a name="output_create_time"></a> [create\_time](#output\_create\_time) | Repository creation timestamp |
| <a name="output_update_time"></a> [update\_time](#output\_update\_time) | Repository last update timestamp |
<!-- END_TF_DOCS -->
