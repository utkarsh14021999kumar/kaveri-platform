# 0005. Single GCP project, per-environment isolation
- Status: Accepted
- Date: 2026-11-23
- Deciders: Solution Architect, Security Engineer

## Context
Enterprise practice is one GCP project per environment. The budget supports one
project: `vibrant-chain-514216-p4` (asia-south1).

## Decision
All environments share the project; each has its own Terraform root, state prefix,
VPC/CIDRs, service accounts and secrets.

| Env | Subnet | Pods | Services | Control plane |
|---|---|---|---|---|
| dev | 10.10.1.0/24 | 10.20.0.0/16 | 10.30.0.0/20 | 172.16.0.0/28 |
| qa | 10.13.1.0/24 | 10.23.0.0/16 | 10.33.0.0/20 | 172.16.0.48/28 |
| uat | 10.11.1.0/24 | 10.21.0.0/16 | 10.31.0.0/20 | 172.16.0.16/28 |
| prod | 10.12.1.0/24 | 10.22.0.0/16 | 10.32.0.0/20 | 172.16.0.32/28 |

## Consequences
Project-level IAM and quotas are shared, so bindings are scoped per resource where
possible. One project per environment is the documented future target.

## Alternatives considered
Separate projects now: stronger isolation but over budget, deferred.
