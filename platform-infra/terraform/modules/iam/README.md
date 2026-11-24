# iam module


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
| [google_project_iam_binding.authoritative](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/project_iam_binding) | resource |
| [google_project_iam_member.additive](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.conditional](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/project_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bindings"></a> [bindings](#input\_bindings) | Map of IAM roles to lists of members | `map(list(string))` | `{}` | no |
| <a name="input_conditional_bindings"></a> [conditional\_bindings](#input\_conditional\_bindings) | IAM role bindings with IAM conditions | <pre>list(object({<br/>    role        = string<br/>    title       = string<br/>    description = string<br/>    expression  = string<br/>    members     = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | IAM management mode: additive or authoritative | `string` | `"additive"` | no |
| <a name="input_projects"></a> [projects](#input\_projects) | GCP project IDs where IAM bindings will be managed | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_members"></a> [members](#output\_members) | Members granted project IAM access |
| <a name="output_projects"></a> [projects](#output\_projects) | Projects that received IAM bindings |
| <a name="output_roles"></a> [roles](#output\_roles) | IAM roles assigned to project members |
<!-- END_TF_DOCS -->
