# 0006. Cost model: short-burst billing
- Status: Accepted
- Date: 2026-11-23
- Deciders: Technical Lead, Project Manager

## Context
Target spend is about INR 500/month. GKE nodes, Cloud NAT, load balancers, Cloud SQL,
VPN and a Jenkins VM all bill hourly.

## Decision
- DEV GKE is zonal (free-tier management credit), one e2-medium, autoscaling capped.
- Hourly-billed lab resources exist only during their lab block, created and destroyed
  by the pipeline; QA/UAT/PROD are provisioned on demand.
- Every infrastructure PR shows a cost estimate; budget alerts at INR 500/1000/2000.

## Consequences
Budget alerts warn but do not stop spending; teardown is part of each phase's exit criteria.

## Alternatives considered
Always-on environments: far above budget, rejected.
