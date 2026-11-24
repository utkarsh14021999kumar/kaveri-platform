# 0009. Policy as code (Conftest) and cost visibility (Infracost GitHub App)
- Status: Accepted
- Date: 2026-11-24

## Decision
- Conftest evaluates the DEV plan JSON inside "Plan DEV" (a required check): P1 zonal DEV GKE, P2 no 0.0.0.0/0 allow,
  P3 required cost labels. Policies have unit tests (conftest verify). Image pinned by digest.
- Infracost GitHub App posts cost estimates on PRs; no secret in the repo.

## Third-party risk (Infracost App)
- Scoped to kaveri-platform only (least privilege; verified 2026-11-24).
- Has read/write on code/PRs/checks, but ruleset protect-main (PR-only, required checks, no bypass) prevents it
  from pushing to main or merging. Revocable via GitHub > Settings > Applications.

## Alternatives
- Infracost CLI in the workflow with an API key: more control, but a repo secret and more maintenance.
