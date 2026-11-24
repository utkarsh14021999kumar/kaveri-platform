# networking module


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
| [google_compute_network.this](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.this](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/compute_subnetwork) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | GCP VPC network name | `string` | n/a | yes |
| <a name="input_pod_cidr"></a> [pod\_cidr](#input\_pod\_cidr) | Secondary range for GKE Pods (canonical IPv4 CIDR, e.g. 10.10.1.0/24). | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | `"asia-south1"` | no |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | Secondary range for GKE Services (canonical IPv4 CIDR, e.g. 10.10.1.0/24). | `string` | n/a | yes |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | Primary subnet range (canonical IPv4 CIDR, e.g. 10.10.1.0/24). | `string` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | GCP subnet name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | ID of the created VPC network |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | Name of the created VPC network |
| <a name="output_network_self_link"></a> [network\_self\_link](#output\_network\_self\_link) | Self-link of the created VPC network |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | GCP project ID associated with the VPC |
| <a name="output_subnets_flow_logs"></a> [subnets\_flow\_logs](#output\_subnets\_flow\_logs) | VPC Flow Logs status |
| <a name="output_subnets_ids"></a> [subnets\_ids](#output\_subnets\_ids) | IDs of the created subnets |
| <a name="output_subnets_ips"></a> [subnets\_ips](#output\_subnets\_ips) | CIDR ranges of the created subnets |
| <a name="output_subnets_names"></a> [subnets\_names](#output\_subnets\_names) | Names of the created subnets |
| <a name="output_subnets_private_access"></a> [subnets\_private\_access](#output\_subnets\_private\_access) | Private Google Access configuration |
| <a name="output_subnets_regions"></a> [subnets\_regions](#output\_subnets\_regions) | Regions where the subnets are created |
| <a name="output_subnets_secondary_ranges"></a> [subnets\_secondary\_ranges](#output\_subnets\_secondary\_ranges) | Secondary IP ranges for GKE Pods and Services |
| <a name="output_subnets_self_links"></a> [subnets\_self\_links](#output\_subnets\_self\_links) | Self-links of the created subnets |
<!-- END_TF_DOCS -->
