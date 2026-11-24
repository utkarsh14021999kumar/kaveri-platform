# KAVERI - High-Level Design (outline; detailed in Phase 2+)
1. **Source & governance:** GitHub repo kaveri-platform; ruleset protect-main (PR-only, required checks, squash).
2. **CI (PR):** Workflow lint, Secret scan, Static checks (fmt, validate, module tests, TFLint, Checkov),
   Plan DEV (read-only WIF identity) + Conftest policies; Infracost cost comment.
3. **CD:** terraform-apply-dev - plan, then approval-gated apply as deployer (environment dev, main only).
4. **Identity:** WIF pool/provider bound to immutable owner/repo IDs; plan SA (narrow read) and deployer SA.
5. **State:** GCS bucket (versioned, private, access-logged); bootstrap layer admin-applied (ADR-0007).
6. **DEV runtime (Phase 2):** VPC + subnet (pod/service ranges), Router + NAT, logged default-deny firewall,
   zonal private GKE with DNS control-plane endpoint, Artifact Registry, Secret Manager containers, alerts.
7. **Later phases:** Argo CD GitOps, signed images + Binary Authorization, observability stack, QA/UAT/PROD.
