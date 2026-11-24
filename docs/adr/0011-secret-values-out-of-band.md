# 0011. Secret values never pass through Terraform
- Status: Accepted - Date: 2026-11-24
**Decision:** Terraform manages Secret Manager containers only; values are injected out-of-band (External Secrets /
secure workflow, Phase 3). Values can never reach state by construction. **Evidence:** PR #41 (no secret_version resource).
