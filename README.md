# KAVERI Platform

Enterprise GCP platform for KAVERI: Terraform infrastructure, CI/CD pipelines and
governance documentation.

- `platform-infra/terraform/bootstrap`: remote state, Workload Identity Federation, deployer identities
- `platform-infra/terraform/modules`: reusable native Google modules
- `platform-infra/terraform/environments`: dev, qa, uat, prod roots
- `docs/`: ADRs, design documents, runbooks

All changes go through pull requests. Infrastructure is applied only by GitHub Actions.
