# cloud-nat module


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
| [google_compute_router_nat.this](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/compute_router_nat) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_drain_nat_ips"></a> [drain\_nat\_ips](#input\_drain\_nat\_ips) | NAT IP addresses to drain | `list(string)` | `[]` | no |
| <a name="input_enable_dynamic_port_allocation"></a> [enable\_dynamic\_port\_allocation](#input\_enable\_dynamic\_port\_allocation) | Enable dynamic NAT port allocation | `bool` | `false` | no |
| <a name="input_log_config_enable"></a> [log\_config\_enable](#input\_log\_config\_enable) | Enable Cloud NAT logging | `bool` | `true` | no |
| <a name="input_log_config_filter"></a> [log\_config\_filter](#input\_log\_config\_filter) | Cloud NAT logging filter | `string` | `"ERRORS_ONLY"` | no |
| <a name="input_max_ports_per_vm"></a> [max\_ports\_per\_vm](#input\_max\_ports\_per\_vm) | Maximum NAT ports per VM, used only with dynamic port allocation (null or a power of two, 64-65536). | `number` | `null` | no |
| <a name="input_min_ports_per_vm"></a> [min\_ports\_per\_vm](#input\_min\_ports\_per\_vm) | Minimum NAT ports per VM (whole number, 2-65536). | `number` | `64` | no |
| <a name="input_name"></a> [name](#input\_name) | Cloud NAT name | `string` | `"corporate-cloud-nat"` | no |
| <a name="input_nat_ips"></a> [nat\_ips](#input\_nat\_ips) | Static external IP self-links; empty list enables automatic allocation | `list(string)` | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | `"asia-south1"` | no |
| <a name="input_router"></a> [router](#input\_router) | Existing Cloud Router name | `string` | n/a | yes |
| <a name="input_subnetworks"></a> [subnetworks](#input\_subnetworks) | Subnetwork and secondary IP ranges requiring NAT | <pre>list(object({<br/>    name                     = string<br/>    source_ip_ranges_to_nat  = list(string)<br/>    secondary_ip_range_names = list(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_id"></a> [nat\_id](#output\_nat\_id) | Cloud NAT resource ID. |
| <a name="output_nat_ip_allocate_option"></a> [nat\_ip\_allocate\_option](#output\_nat\_ip\_allocate\_option) | NAT IP allocation mode. |
| <a name="output_nat_name"></a> [nat\_name](#output\_nat\_name) | Name of the Cloud NAT. |
| <a name="output_nat_region"></a> [nat\_region](#output\_nat\_region) | Region of the Cloud NAT. |
| <a name="output_nat_router_name"></a> [nat\_router\_name](#output\_nat\_router\_name) | Cloud Router associated with the NAT. |
<!-- END_TF_DOCS -->
