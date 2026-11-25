# Architecture Decision Records (ADR)

Each ADR records one significant decision: context, decision, consequences, alternatives.
Status flow: Proposed -> Accepted (on merge) -> Superseded/Deprecated (by a later ADR).
New ADRs: copy the template below into `NNNN-short-title.md` and open a PR.

| ADR | Title | Status |
|---|---|---|
| [0001](0001-dedicated-platform-repository.md) | Dedicated platform repository `kaveri-platform` | Accepted |
| [0002](0002-trunk-based-pr-only-main.md) | Trunk-based development, PR-only changes on `main` | Accepted |
| [0003](0003-three-repository-model.md) | Three-repository model | Accepted |
| [0004](0004-reference-application.md) | Reference application | Accepted |
| [0005](0005-single-project-per-environment-isolation.md) | Single GCP project, per-environment isolation | Accepted |
| [0006](0006-cost-model-short-burst.md) | Cost model: short-burst billing | Accepted |
| [0007](0007-pipeline-only-infrastructure-changes.md) | Infrastructure changes only through the pipeline | Accepted |
| [0008](0008-deployer-sa-admin-risk-acceptance.md) | Deployer SA administration: accepted risk | Accepted |
| [0009](0009-policy-as-code-and-cost-visibility.md) | Policy as code and cost visibility | Accepted |
| [0010](0010-gke-dns-control-plane-endpoint.md) | GKE DNS control-plane endpoint | Accepted |
| [0011](0011-secret-values-out-of-band.md) | Secret values out-of-band | Accepted |
| [0012](0012-ci-supply-chain-and-tests.md) | CI supply chain and tests | Accepted |

## Template

    # NNNN. Title
    - Status: Proposed
    - Date: YYYY-MM-DD
    - Deciders: Technical Lead
    ## Context
    ## Decision
    ## Consequences
    ## Alternatives considered
- [ADR-0014](0014-application-repository-import.md) - Application repository: pinned upstream import, DEV service scope
