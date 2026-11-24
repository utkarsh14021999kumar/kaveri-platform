# firewall module


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
| [google_compute_firewall.egress](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.ingress](https://registry.terraform.io/providers/hashicorp/google/6.50.0/docs/resources/compute_firewall) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | List of outbound firewall rules | <pre>list(object({<br/>    name                    = string<br/>    description             = optional(string, null)<br/>    disabled                = optional(bool, null)<br/>    priority                = optional(number, null)<br/>    destination_ranges      = optional(list(string), [])<br/>    source_ranges           = optional(list(string), [])<br/>    source_tags             = optional(list(string))<br/>    source_service_accounts = optional(list(string))<br/>    target_tags             = optional(list(string))<br/>    target_service_accounts = optional(list(string))<br/><br/>    allow = optional(list(object({<br/>      protocol = string<br/>      ports    = optional(list(string))<br/>    })), [])<br/><br/>    deny = optional(list(object({<br/>      protocol = string<br/>      ports    = optional(list(string))<br/>    })), [])<br/><br/>    log_config = optional(object({<br/>      metadata = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of inbound firewall rules | <pre>list(object({<br/>    name                    = string<br/>    description             = optional(string, null)<br/>    disabled                = optional(bool, null)<br/>    priority                = optional(number, null)<br/>    destination_ranges      = optional(list(string), [])<br/>    source_ranges           = optional(list(string), [])<br/>    source_tags             = optional(list(string))<br/>    source_service_accounts = optional(list(string))<br/>    target_tags             = optional(list(string))<br/>    target_service_accounts = optional(list(string))<br/><br/>    allow = optional(list(object({<br/>      protocol = string<br/>      ports    = optional(list(string))<br/>    })), [])<br/><br/>    deny = optional(list(object({<br/>      protocol = string<br/>      ports    = optional(list(string))<br/>    })), [])<br/><br/>    log_config = optional(object({<br/>      metadata = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Existing VPC network name | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_rules"></a> [firewall\_rules](#output\_firewall\_rules) | Created firewall rule resources |
| <a name="output_firewall_rules_ingress_egress"></a> [firewall\_rules\_ingress\_egress](#output\_firewall\_rules\_ingress\_egress) | Created ingress and egress firewall rule resources |
<!-- END_TF_DOCS -->
