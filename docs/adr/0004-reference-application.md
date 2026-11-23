# 0004. Reference application
- Status: Accepted
- Date: 2026-11-23
- Deciders: Application Lead, Technical Lead

## Context
The platform needs a realistic microservices workload for CI, GitOps, service mesh,
observability and the 50 planned incident drills (gRPC, Redis, load testing, mTLS).

## Decision
Use Google's Online Boutique (`GoogleCloudPlatform/microservices-demo`, 11 services):
gRPC, Redis cart store, Locust load generator, Helm/Kustomize/Istio manifests.

## Consequences
Most incident drills map directly onto the application. The fork is pinned to a release tag.

## Alternatives considered
Habitcentric (original proposal): viable, but gRPC, Redis and mesh drills need extra work.
Can be revisited by superseding this ADR.
