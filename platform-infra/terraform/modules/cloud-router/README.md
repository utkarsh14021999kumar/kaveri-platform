# cloud-router module


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
| [google_compute_router.this](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/compute_router) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bgp"></a> [bgp](#input\_bgp) | Optional BGP configuration | <pre>object({<br/>    asn               = number<br/>    advertise_mode    = optional(string, "CUSTOM")<br/>    advertised_groups = optional(list(string), [])<br/>    advertised_ip_ranges = optional(list(object({<br/>      range       = string<br/>      description = optional(string)<br/>    })), [])<br/>    keepalive_interval = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Cloud Router description | `string` | `"Corporate Cloud Router managed by Terraform"` | no |
| <a name="input_encrypted_interconnect_router"></a> [encrypted\_interconnect\_router](#input\_encrypted\_interconnect\_router) | Whether this router is dedicated to encrypted Interconnect | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Cloud Router name | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | VPC network self-link or name | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | `"asia-south1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_router_id"></a> [router\_id](#output\_router\_id) | Cloud Router resource ID |
| <a name="output_router_name"></a> [router\_name](#output\_router\_name) | Cloud Router name |
| <a name="output_router_network"></a> [router\_network](#output\_router\_network) | VPC network associated with the router |
| <a name="output_router_region"></a> [router\_region](#output\_router\_region) | Cloud Router region |
| <a name="output_router_self_link"></a> [router\_self\_link](#output\_router\_self\_link) | Cloud Router self-link |
<!-- END_TF_DOCS -->
