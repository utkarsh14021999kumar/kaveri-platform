# GKE Terraform Module

Uses native Google Terraform provider resources.

Provider:
- hashicorp/google = 6.50.0

Resources:
- google_container_cluster
- google_container_node_pool

Features:
- Regional GKE
- Private nodes
- Workload Identity
- Gateway API Standard
- VPC-native Pod and Service IP ranges
- Network Policy
- Shielded Nodes
- Node pool autoscaling
- Auto repair and auto upgrade
- Cloud Monitoring and Cloud Logging
- Deletion protection

Requires an existing VPC, subnet and secondary IP ranges.

No infrastructure is deployed by initialization or validation.

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
| [google_container_cluster.this](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/container_cluster) | resource |
| [google_container_node_pool.this](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/container_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | GKE cluster name | `string` | `"gke-dev"` | no |
| <a name="input_enable_dns_endpoint"></a> [enable\_dns\_endpoint](#input\_enable\_dns\_endpoint) | Expose the control plane through the IAM-controlled DNS-based endpoint (no public IP, no authorized networks). | `bool` | `false` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Disable public access to the GKE Kubernetes control-plane endpoint | `bool` | `true` | no |
| <a name="input_ip_range_pods"></a> [ip\_range\_pods](#input\_ip\_range\_pods) | Existing secondary Pod IP range name | `string` | n/a | yes |
| <a name="input_ip_range_services"></a> [ip\_range\_services](#input\_ip\_range\_services) | Existing secondary Service IP range name | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | GKE resource labels | `map(string)` | <pre>{<br/>  "environment": "dev",<br/>  "managed_by": "terraform",<br/>  "platform": "gke"<br/>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | Cluster location: a zone (zonal cluster, e.g. asia-south1-a) or a region (regional cluster). Defaults to var.region. | `string` | `null` | no |
| <a name="input_master_authorized_networks"></a> [master\_authorized\_networks](#input\_master\_authorized\_networks) | Authorized control-plane access CIDRs | <pre>list(object({<br/>    cidr_block   = string<br/>    display_name = string<br/>  }))</pre> | `[]` | no |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | Non-overlapping /28 control-plane CIDR | `string` | `"172.16.0.0/28"` | no |
| <a name="input_network"></a> [network](#input\_network) | Existing VPC network name | `string` | n/a | yes |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | GKE node pool configurations | <pre>list(object({<br/>    name               = string<br/>    machine_type       = string<br/>    node_locations     = string<br/>    min_count          = number<br/>    max_count          = number<br/>    initial_node_count = number<br/>    disk_size_gb       = number<br/>    disk_type          = string<br/>    image_type         = string<br/>    auto_repair        = bool<br/>    auto_upgrade       = bool<br/>  }))</pre> | <pre>[<br/>  {<br/>    "auto_repair": true,<br/>    "auto_upgrade": true,<br/>    "disk_size_gb": 50,<br/>    "disk_type": "pd-balanced",<br/>    "image_type": "COS_CONTAINERD",<br/>    "initial_node_count": 1,<br/>    "machine_type": "e2-medium",<br/>    "max_count": 2,<br/>    "min_count": 1,<br/>    "name": "system-pool",<br/>    "node_locations": "asia-south1-a,asia-south1-b,asia-south1-c"<br/>  }<br/>]</pre> | no |
| <a name="input_node_service_account_email"></a> [node\_service\_account\_email](#input\_node\_service\_account\_email) | Dedicated service account attached to GKE worker nodes | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | `"vibrant-chain-514216-p4"` | no |
| <a name="input_region"></a> [region](#input\_region) | GKE regional location | `string` | `"asia-south1"` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | Existing subnet name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | GKE cluster CA certificate |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | GKE Kubernetes API endpoint |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | GKE cluster ID |
| <a name="output_cluster_location"></a> [cluster\_location](#output\_cluster\_location) | GKE cluster location |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | GKE cluster name |
| <a name="output_gateway_api_channel"></a> [gateway\_api\_channel](#output\_gateway\_api\_channel) | GKE Gateway API channel |
| <a name="output_node_pool_names"></a> [node\_pool\_names](#output\_node\_pool\_names) | GKE node pool names |
| <a name="output_node_pool_versions"></a> [node\_pool\_versions](#output\_node\_pool\_versions) | GKE node pool versions |
| <a name="output_workload_identity_pool"></a> [workload\_identity\_pool](#output\_workload\_identity\_pool) | GKE Workload Identity pool |
<!-- END_TF_DOCS -->
