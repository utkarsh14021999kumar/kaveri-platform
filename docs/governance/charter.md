# KAVERI - Project Charter
**Purpose:** build an enterprise-grade GCP DevOps/DevSecOps platform (GKE, GitOps, secure supply chain, observability)
operated with corporate controls: tickets, PRs, required checks, approvals, change records, evidence.

**In scope:** platform IaC (Terraform), keyless CI/CD (GitHub Actions + WIF), GKE environments DEV/QA/UAT/PROD,
reference application Online Boutique (ADR-0004), GitOps (Argo CD), security, observability, FinOps, incident practice.
**Out of scope:** multi-project landing zone (target in ADR-0005), production customer data.

**Objectives:** (1) every change via reviewed PR + automated gates; (2) zero long-lived keys; (3) least privilege;
(4) cost within INR 2,000/month (ADR-0006, budget alerts); (5) documented decisions (ADRs) and evidence per change.

**Constraints:** single GCP project vibrant-chain-514216-p4 (asia-south1); single operator holding all roles;
public repository (no secrets or personal data committed).

**Phases:** 1 Foundation - 2 Walking skeleton - 3 Secure supply chain - 4 Operability - 5 Environments & releases -
6 Edge, data, resilience, cost - 7 Incidents & handover.
