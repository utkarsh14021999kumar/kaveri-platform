# 0010. GKE control plane reached via DNS-based endpoint
- Status: Accepted - Date: 2026-11-24
**Decision:** private GKE with enable_dns_endpoint; CI reaches the API by DNS name, authorised by IAM - no public IP,
no authorised-network CIDRs to maintain. **Evidence:** PR #28 plan (dns_endpoint_config, allow_external_traffic).
