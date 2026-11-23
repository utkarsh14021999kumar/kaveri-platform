# 0003. Three-repository model
- Status: Accepted
- Date: 2026-11-23
- Deciders: Solution Architect, Technical Lead

## Context
Infrastructure, application code and deployment manifests change at different rates
and need different owners and approvers.

## Decision
| Repository | Contents | Changed by |
|---|---|---|
| `kaveri-platform` | Terraform, pipelines, platform docs | Platform team |
| Application fork | Service source, Dockerfiles, app CI | Application team |
| `kaveri-gitops` | Helm charts/values, Argo CD apps | CI digest bumps, release manager |

## Consequences
Clear ownership and blast radius; Argo CD watches only `kaveri-gitops`; app CI needs
a scoped identity to open digest-bump PRs there.

## Alternatives considered
Single monorepo: mixes approvals and pipeline triggers, rejected.
