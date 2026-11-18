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
