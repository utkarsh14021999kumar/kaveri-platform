# KAVERI - RAID log (Phase 1 close)
## Risks
| ID | Risk | Mitigation | Owner |
|---|---|---|---|
| R1 | Deployer has project-wide iam.serviceAccountAdmin | ADR-0008 compensating controls; follow-up #38 | Security |
| R2 | Infracost App has write scopes | Scoped to 1 repo; ruleset blocks push/merge; ADR-0009 | Security |
| R3 | Single project = shared blast radius across environments | ADR-0005 target: project per environment | Tech Lead |
| R4 | Apply job (download-artifact v8) not yet exercised end-to-end | First Phase 2 apply; fails safe (no plan file = no apply) | Platform |
| R5 | Budget alerts notify but do not cap spend | Short-burst model, teardown discipline (ADR-0006) | FinOps |
## Assumptions
- A1 Free-tier zonal GKE management fee applies to one zonal cluster. - A2 Single operator acts in all roles.
## Issues / follow-ups
- I1 #38 IAM-condition scoping of deployer SA admin. - I2 CIDR overlap check (cross-variable validation).
- I3 Infracost lists 7 pre-existing FinOps issues on main - triage in Phase 2.
- I4 auth warning "create_credentials_file with empty workspace" in smoke test - cosmetic.
- I5 Confirm GCS access-log objects arrive in tfstate-access/ (end-to-end proof for #19).
## Dependencies
- D1 GitHub (Actions, rulesets), Google Cloud APIs, Infracost SaaS, container registries (ghcr.io, Docker Hub, quay.io).
