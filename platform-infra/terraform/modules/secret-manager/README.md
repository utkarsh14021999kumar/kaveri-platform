# secret-manager module


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
| [google_kms_crypto_key_iam_member.secret_manager](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_pubsub_topic_iam_member.secret_manager](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/pubsub_topic_iam_member) | resource |
| [google_secret_manager_secret.this](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_iam_member.accessor](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/secret_manager_secret_iam_member) | resource |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_kms_permissions"></a> [add\_kms\_permissions](#input\_add\_kms\_permissions) | KMS crypto key resources requiring Secret Manager permissions | `list(string)` | `[]` | no |
| <a name="input_add_pubsub_permissions"></a> [add\_pubsub\_permissions](#input\_add\_pubsub\_permissions) | Pub/Sub topic resources requiring Secret Manager permissions | `list(string)` | `[]` | no |
| <a name="input_automatic_replication"></a> [automatic\_replication](#input\_automatic\_replication) | Automatic replication configuration with optional CMEK | <pre>map(object({<br/>    kms_key_name = string<br/>  }))</pre> | `{}` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels assigned to individual secrets | `map(map(string))` | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_secret_accessors_list"></a> [secret\_accessors\_list](#input\_secret\_accessors\_list) | IAM members permitted to access managed secrets | `list(string)` | `[]` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Secret CONTAINERS (metadata only). Secret values never pass through Terraform - they are injected out-of-band, so nothing here is sensitive and nothing reaches state. | <pre>list(object({<br/>    name               = string<br/>    rotation_period    = optional(string)<br/>    next_rotation_time = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | Pub/Sub topics for secret rotation notifications | <pre>map(list(object({<br/>    name = string<br/>  })))</pre> | `{}` | no |
| <a name="input_user_managed_replication"></a> [user\_managed\_replication](#input\_user\_managed\_replication) | User-managed replication locations and CMEK keys | <pre>map(list(object({<br/>    location     = string<br/>    kms_key_name = string<br/>  })))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_names"></a> [secret\_names](#output\_secret\_names) | Names of managed Secret Manager secrets |
<!-- END_TF_DOCS -->
