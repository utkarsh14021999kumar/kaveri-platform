# service-accounts module


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
| [google_project_iam_member.roles](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/project_iam_member) | resource |
| [google_service_account.this](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Default description for service accounts | `string` | `"Corporate GCP platform service account"` | no |
| <a name="input_descriptions"></a> [descriptions](#input\_descriptions) | Individual service account descriptions | `list(string)` | `[]` | no |
| <a name="input_disabled"></a> [disabled](#input\_disabled) | Map of service account names to disabled status | `map(bool)` | `{}` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display name for created service accounts | `string` | `"Kaveri GCP Platform Service Account"` | no |
| <a name="input_names"></a> [names](#input\_names) | Names of service accounts to create | `list(string)` | `[]` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for service account names | `string` | `"kaveri"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID where service accounts will be created | `string` | n/a | yes |
| <a name="input_project_roles"></a> [project\_roles](#input\_project\_roles) | Optional project-level IAM roles in project\_id=>role format | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_account_emails"></a> [service\_account\_emails](#output\_service\_account\_emails) | Service account email addresses indexed by name |
| <a name="output_service_account_emails_list"></a> [service\_account\_emails\_list](#output\_service\_account\_emails\_list) | List of service account email addresses |
| <a name="output_service_account_iam_emails"></a> [service\_account\_iam\_emails](#output\_service\_account\_iam\_emails) | IAM-format service account email addresses indexed by name |
| <a name="output_service_account_iam_emails_list"></a> [service\_account\_iam\_emails\_list](#output\_service\_account\_iam\_emails\_list) | List of IAM-format service account email addresses |
| <a name="output_service_accounts_map"></a> [service\_accounts\_map](#output\_service\_accounts\_map) | Created service account resources indexed by name |
<!-- END_TF_DOCS -->
