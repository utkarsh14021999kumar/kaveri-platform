# KAVERI - Non-Functional Requirements
| Area | Requirement | Target / evidence |
|---|---|---|
| Security | Keyless auth (WIF), immutable-ID trust, least-privilege roles | ADR-0007, #18, #9 |
| Security | Supply chain: Actions pinned to SHAs, images to digests | #44 (PR #46) |
| Security | Secret values never in Terraform state | #40 (PR #41) |
| Change control | Required checks + approval gate before deployer use | #24, #22 |
| Cost | DEV zonal; budget INR 2,000/month with 25/50/100% + forecast alerts | ADR-0006, step 17 |
| Reliability | DEV best effort; PROD availability target 99.5% (Phase 5/6) | - |
| Recovery | DEV RTO 4 h / RPO 24 h (rebuild from code + state); PROD RTO 1 h / RPO 15 min (Phase 6 target) | Phase 6 drill |
| Observability | Metrics, logs, traces with SLOs and alerting (Phase 4) | - |
| Auditability | Every change has ticket, PR, plan evidence; admin applies have change records | issues/PRs |
