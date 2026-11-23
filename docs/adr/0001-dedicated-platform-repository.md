# 0001. Dedicated platform repository `kaveri-platform`
- Status: Accepted
- Date: 2026-11-23
- Deciders: Technical Lead, Solution Architect

## Context
Platform code lived as an untracked folder inside `kaverigcp`, a full copy of Google Cloud
Foundation Fabric. That repository carried Fabric's own CI workflows and a `.gitignore` that
blocked Terraform lock files. None of our work was committed.

## Decision
Create a dedicated repository `utkarsh14021999kumar/kaveri-platform` containing only KAVERI
platform code (Terraform bootstrap, modules, environments), pipelines and documentation.
`kaverigcp` is kept unchanged as a read-only reference.

## Consequences
- Clean history starting from baseline commit `eb1fe0c`.
- Workload Identity Federation variables must reference `kaveri-platform` (Phase 3 fix).
- Only our own workflows run; only root lock files are committed.

## Alternatives considered
- Rewrite `kaverigcp` history with a force-push: destroys history, rejected.
- Commit next to the Fabric code: unrelated workflows and noise, rejected.
