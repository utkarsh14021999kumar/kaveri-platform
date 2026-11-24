# Phase 1 (Foundation) - Completion Review
## Exit criteria (verified by script in the close-out ticket)
| # | Criterion | Evidence |
|---|---|---|
| E1 | main protected: PR-only, required checks, no bypass | ruleset protect-main; refused merge PR #26 |
| E2 | Keyless CI with immutable-ID WIF; drill RCA | #9, #12 RCA |
| E3 | PR pipeline: lint, secret scan, fmt/validate, module tests, TFLint, Checkov, plan, Conftest, Infracost | #21, #46, #49 |
| E4 | Approval-gated apply; block + allow paths tested | #22 (T1/T1b) |
| E5 | Least privilege: plan identity narrow roles; deployer risk accepted | #18, ADR-0008 |
| E6 | Hardening: zonal GKE, metadata server, labels, firewall, state logs, secrets containers-only, validation | #27 #17 #16 #19 #40 #42 |
| E7 | Checkov baseline reduced 9 -> 1 (only Binary Authorization, Phase 3) | .checkov.baseline |
| E8 | Budget alerts live (INR 500/1000/2000 + forecast) | step 17 change record |
| E9 | Governance docs and ADR-0001..0012 | docs/ |
## Deviations and corrections (recorded, not hidden)
- Evidence once written before observation (T1) - corrected on #22.
- #17 closed early - reopened, fixed by PR #30.
- Failure test #45 invalid (failed at validate) - corrected, redone as #47.
- Evidence parsers missed literal colour codes - fixed; commit identity corrected at close-out.
- Budget apply ran before its PR merged (#54) - corrected: merged afterwards, plan from main = No changes.
## Lessons
Verify before recording; gates halt (markers), never just print; negative tests assert step and reason;
inspect module shapes before editing; whitespace-tolerant patterns; idempotent change scripts.
## Carry-over to Phase 2
RAID I1-I5, R4 (first apply exercises apply job), Infracost findings triage.
