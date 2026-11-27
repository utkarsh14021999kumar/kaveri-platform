# ADR-0016: GitOps delivery with Argo CD

- Status: Accepted
- Date: 2026-11-27
- Deciders: Technical Lead

## Context
Phase 2 needs a pull-based deployment model for DEV: the cluster converges on a reviewed desired state, every change is a Git commit, and rollback is a revert. CI already produces immutable image digests (ADR-0015).

## Decision
1. kaveri-gitops holds the desired state: apps/boutique/base (vendored from kaveri-boutique at a recorded commit), apps/boutique/overlays/dev (namespace kaveri-dev, images by digest only, no public LoadBalancer), platform/dev (namespace and Workload Identity service account), clusters/dev (Argo CD Application manifests).
2. The repository is public: it holds no secrets (Gitleaks in CI; secret values out-of-band per ADR-0011), and the image digests are already visible in kaveri-boutique CI. Registry pulls still require the node identity. Moving to a private repository with a GitHub App credential is the path once an organisation account exists.
3. main is PR-only (squash) with the required check validate: Gitleaks, every kustomization renders, kubeconform schema validation, overlays use @sha256 digests only (proven by a deliberate failure test).
4. Argo CD is installed by the platform-addons-dev pipeline (deployer via WIF, approval on environment dev, DNS control-plane endpoint) from a pinned Helm chart whose sha256 is committed and verified before install. No manual helm or kubectl.
5. App-of-apps: root application kaveri-dev-root (path clusters/dev) in AppProject kaveri, which allows only the kaveri-gitops source, the argocd and kaveri-dev namespaces, and Namespace as the only cluster-scoped kind. Automated sync with prune and self-heal.
6. Argo CD runs on the system pool (platform add-ons, ADR-0013) with small requests; its API server is ClusterIP only and reached by port-forward through the DNS endpoint. SSO and Argo CD RBAC hardening come in the security phase.
7. Online Boutique becomes an Argo CD application in step 2.19 through a digest-promotion PR; until then the overlay is validated but not deployed.

## Consequences
- Drift is reverted automatically; manual kubectl changes do not persist (self-heal drill in the 2.16 evidence).
- Promotion and rollback are pull requests; the audit trail is Git history plus Argo CD sync history.
- Third-party images (redis) are pinned by digest but not scanned by our CI; mirroring them into Artifact Registry is tracked with #79.

## Alternatives considered
- Flux CD: comparable; Argo CD chosen for its UI and app-of-apps visibility for reviewers.
- Push-based kubectl or helm from each CI pipeline: no drift correction and cluster write access from every app pipeline. Rejected.
- Remote kustomize base pointing at kaveri-boutique: smaller repository, but rendering would depend on a second repository at sync time. Rejected for DEV; revisit with a release process.
