# ADR-0014: Application repository - pinned upstream import, DEV service scope

- Status: Accepted
- Date: 2026-11-25
- Related: ADR-0003 (three-repository model), ADR-0004 (Online Boutique as reference app), ticket #70

## Context
Phase 2 needs the Online Boutique source in a repository KAVERI fully controls, with its own CI and least-privilege identity.
Upstream (GoogleCloudPlatform/microservices-demo) ships its own CI workflows, sample Terraform and Cloud Build files.

## Decision
1. Create kaveri-boutique as a new public repository and import upstream release v0.10.7 (commit 5b608cb1dfe317d05e4f1bb8c99b7618452fde87) as a single
   baseline commit. Do not use a GitHub fork.
2. Remove upstream .github/ (CI), terraform/, cloudbuild.yaml and .deploystack/ at import; keep LICENSE (Apache-2.0)
   and record provenance in UPSTREAM.md.
3. DEV deploys the 10 core services + Redis. Not deployed: shoppingassistantservice (requires Vertex AI/AlloyDB),
   loadgenerator (test tool, planned for Phase 4 load/SLO testing).
4. Same governance as kaveri-platform: squash-only, ruleset protect-main (PR-only, no bypass), CODEOWNERS, PR template.
   Required checks are added when the app CI exists (step 2.13).
5. Repository created through an isolated, temporary break-glass session; daily work uses the fine-grained token
   scoped to kaveri-platform and kaveri-boutique only.

## Alternatives considered
- GitHub fork: PRs default to upstream, upstream workflows come along, restructuring is constrained. Rejected.
- Monorepo inside kaveri-platform: mixes app and infra change control and pipelines. Rejected (ADR-0003).
- Track upstream main: not reproducible. Rejected in favour of a pinned release tag + commit SHA.

## Consequences
- Upgrades are deliberate: new tag -> ticket -> re-import on a branch -> review diff -> CI -> PR.
- Upstream history is not in the repo; UPSTREAM.md links the exact source commit.
- Repository ID 1471398178 is the immutable identifier used for Workload Identity Federation (step 2.12).
