# 0007. Infrastructure changes only through the pipeline
- Status: Accepted
- Date: 2026-11-23
- Deciders: Technical Lead, Security Engineer

## Context
Manual `terraform apply` or console changes are unreviewed, unaudited and cause drift.

## Decision
GCP resources are created, changed or destroyed only by GitHub Actions after PR review
and environment approval, using Workload Identity Federation (no JSON keys).
Engineers may run read-only and local commands (inspect, fmt, validate).

Documented one-time exceptions:
1. Repository bootstrap (creation, baseline import, ruleset), completed 2026-11-23.
2. Identity bootstrap: the first apply creating the WIF pool, provider and deployer
   identities, because CI cannot authenticate before that trust exists.

## Consequences
Every infrastructure change has a plan, scan results, cost estimate and approval record.
Drift detection treats any out-of-band change as an incident.

## Alternatives considered
Engineer-run applies with peer review: no enforced audit trail, rejected.
