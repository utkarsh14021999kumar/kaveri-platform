# 0002. Trunk-based development, PR-only changes on `main`
- Status: Accepted
- Date: 2026-11-23
- Deciders: Technical Lead, DevOps Engineer

## Context
Infrastructure changes must be reviewable, traceable to a ticket and reversible.

## Decision
- Default branch `main`; short-lived branches `feature/`, `fix/`, `docs/` + ticket + slug.
- Ruleset `protect-main`: PR required, no force-push, no deletion, conversations resolved.
- Squash merge only; merged branches deleted automatically.
- Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`).
- Required approvals = 0 while one engineer operates the repo; CI checks become
  required in Phase 5; raise to 1 with CODEOWNERS when a second reviewer joins.
- GitHub access uses a fine-grained token scoped to this repo; elevated sessions are
  temporary and revoked after use.

## Consequences
Every change has a ticket, a PR, review evidence and one revertible commit.
Verified: a direct push to `main` was rejected (GH013) during repository bootstrap.

## Alternatives considered
GitFlow (long-lived develop/release branches): more overhead, rejected.
