# ADR-0015: Application CI for kaveri-boutique

- Status: Accepted
- Phase 2, step 2.13

## Context
kaveri-boutique holds Online Boutique (about 12 services in Go, C#, Node.js, Python and Java). Images must be tested and scanned before they reach Artifact Registry, and pushed by digest so GitOps (2.15-2.19) deploys exact bytes. CI authenticates keylessly as `kaveri-ci-image-pusher` (step 2.12), which works only from `refs/heads/main`.

## Decision
1. One workflow, `.github/workflows/ci.yml`, on pull requests to main, pushes to main and manual dispatch.
2. The service matrix is generated from the Dockerfiles under `src/`, never maintained by hand.
3. Per service, in order: unit tests (Go `go test ./...`; C# `dotnet test`; others recorded as having none) -> docker build -> Trivy filesystem scan -> Trivy image scan -> SBOM (CycloneDX, CI artifact) -> main only: WIF auth -> push -> read back by digest.
4. Authentication runs after build and scan, so the `gha-creds-*.json` file written by the auth action can never enter a build context (finding from 2.12 Q4).
5. Vulnerability gate: CRITICAL with a fix available fails the build; HIGH is reported. Exceptions only through `.trivyignore`, one CVE per line with justification, expiry date and ticket.
6. Secret scanning: Gitleaks on the commit range of each change, plus a one-time full-history baseline attached to the 2.13 ticket. Accepted findings go into `.gitleaksignore` with justification.
7. Code quality: SonarCloud with the quality gate awaited. The generic scanner covers Go, Node.js and Python. Java (adservice), C# (cartservice) and coverage import are tracked in follow-up 2.13b.
8. Tags are `<sha12>-r<run_id>` because `kaveri-dev-docker` has immutable tags. Everything downstream uses the digest, never the tag.
9. Images are built with `--provenance=false`: one manifest per image keeps digests simple and the 2.14 cleanup policy safe. SBOMs are kept as CI artifacts; signing and registry attestations come later, together with the custom pusher role from the AR-attachments risk ticket.
10. One required status check, `ci-gate`, aggregates every job (safe with a matrix, no checks stuck pending). Every change builds all services, so results are deterministic; change detection is a later optimisation.
11. Every action is pinned to a full commit SHA of a release at least 14 days old; tool images are pinned by digest.
12. Pull requests from forks get no secrets, so the SonarCloud job fails for them. Acceptable for a single-maintainer repository.

## Consequences
- Each merge to main publishes `release-digests.json` (service -> image@digest), the input for the GitOps overlays.
- Upstream images with fixable CRITICAL CVEs block CI until they are patched or formally excepted.
- Full builds use more runner minutes than change detection; acceptable for a public repository.

## Verification
F1 vulnerable image blocked; F2 planted fake secret blocked; F3 failing unit test blocked; F4 pull-request builds never push.

## Pinned tools (resolved 2026-11-25; releases older than 14 days)

| Tool | Release | Pin |
|---|---|---|
| actions/checkout | v7.0.1 | `3d3c42e5aac5ba805825da76410c181273ba90b1` |
| actions/setup-go | v7.0.0 | `b7ad1dad31e06c5925ef5d2fc7ad053ef454303e` |
| actions/setup-dotnet | v6.1.0 | `0f4a354dd5547a28c70b7853dbd95d5b67886e73` |
| actions/upload-artifact | v7.0.2 | `cf430e030ddbb5b0abf93d22962f4752f3646cd9` |
| actions/download-artifact | v8.0.2 | `9000827ccba6bdab643e8b6fd33ac0654aef8333` |
| SonarSource/sonarqube-scan-action | v8.4.1 | `e805d875275f728fac1885b413934be6d7c63f65` |
| Trivy | v0.76.2 | `aquasec/trivy@sha256:8f6bb947dbc528902e11f2f5be52f7b519f6a39d5d148f41166f2040499768fb` |
| Gitleaks | v8.30.1 | `zricethezav/gitleaks@sha256:c00b6bd0aeb3071cbcb79009cb16a60dd9e0a7c60e2be9ab65d25e6bc8abbb7f` |

Ticket: #76. Follow-up: #77.
