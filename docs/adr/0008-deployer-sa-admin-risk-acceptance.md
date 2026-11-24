# 0008. Deployer service-account administration: accepted risk (single-project model)
- Status: Accepted
- Date: 2026-11-24
- Deciders: Technical Lead, Security Engineer

## Context
The deployer holds roles/iam.serviceAccountAdmin project-wide (Checkov CKV_GCP_49). It needs to create
environment service accounts and set IAM on them (node-SA actAs, Workload Identity bindings).
All environments share one project (ADR-0005), so "project-wide" covers every environment.

## Decision
Accept the risk for now, with compensating controls; replace the Checkov baseline entry with an inline
skip that references this ADR.

## Compensating controls
- Deployer usable only from GitHub environment dev, on main, after reviewer approval (tested: T1/T1b).
- Every change is a reviewed PR with plan evidence and required checks.
- projectIamAdmin is conditional (deployer may grant only roles/container.defaultNodeServiceAccount).
- WIF trust bound to immutable owner/repo IDs.
- Drift detection (Phase 2) and Cloud Audit Logs detect unexpected service-account changes.

## Revisit triggers
- Follow-up #38: IAM-condition scoping, after a test proves the service-account resource.name format.
- Moving to one project per environment (ADR-0005 target) removes the cross-environment exposure.

## Alternatives considered
- IAM condition now: rejected for now - unverified condition format could silently block the first apply.
- Separate projects now: over budget (ADR-0005, ADR-0006).
