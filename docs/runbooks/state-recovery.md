# Runbook: Terraform state recovery (DEV)

Owner: Platform Engineering. Approval: change ticket required before step 6.
Last drill: 2026-11-25 (ticket in history; drill A pass, drill B demonstrated the risk).

## When to use
- The state object was deleted, overwritten, or corrupted (init/plan errors about state, or a plan that wants to
  create resources that already exist).
- NOT for normal drift (use a plan + PR) and NOT for a stuck lock (see "Locks").

## Facts
- Bucket: gs://vibrant-chain-514216-p4-tfstate (versioning ON, soft delete 7 days, public access prevented).
- DEV object: environments/dev/default.tfstate ; lock object: environments/dev/default.tflock
- Every write creates a new generation. serial increases by 1 per write; lineage must never change.

## Procedure
1. Freeze changes: no terraform-apply-dev or dev-pause run in progress.

        gh run list --repo utkarsh14021999kumar/kaveri-platform --workflow terraform-apply-dev.yml --limit 3
        gcloud storage ls gs://vibrant-chain-514216-p4-tfstate/environments/dev/ | grep -i tflock

2. List generations (newest last):

        O=gs://vibrant-chain-514216-p4-tfstate/environments/dev/default.tfstate
        gcloud storage ls --all-versions -l "$O"

3. Download candidates (read-only) and compare serial, lineage, managed instance count:

        gcloud storage cp "$O#<GENERATION>" /tmp/candidate.tfstate
        jq '{serial, lineage, n: ([.resources[]|select(.mode=="managed")|.instances[]]|length)}' /tmp/candidate.tfstate

   Pick the HIGHEST serial with the SAME lineage and the expected instance count. A generation written in the
   middle of an apply can be missing resources (drill B: restoring it would duplicate 2 alert policies).
4. Test in an isolated copy, never against the real backend:

        cp -r platform-infra/terraform /tmp/rtest
        printf 'terraform {\n  backend "local" { path = "/tmp/candidate.tfstate" }\n}\n' \
          > /tmp/rtest/environments/dev/backend_override.tf
        TF_DATA_DIR=/tmp/rtest-data terraform -chdir=/tmp/rtest/environments/dev init -reconfigure -input=false
        TF_DATA_DIR=/tmp/rtest-data terraform -chdir=/tmp/rtest/environments/dev plan -lock=false -input=false

   Accept only if the plan creates/destroys nothing that already exists (expected: the pipeline's plan).
5. Open a change ticket with steps 2-4 output.
6. Restore (creates a NEW current generation; older ones stay):

        gcloud storage cp "$O#<GENERATION>" "$O"

   If the object was deleted within 7 days and no live version exists: gcloud storage restore "$O#<GENERATION>"
7. Verify through the pipeline: terraform-apply-dev with apply=false must show the plan accepted in step 4.
8. Record evidence on the change ticket and close it.

## Locks
- A lock object without a running workflow = stale lock. Confirm no run is in progress (step 1), then remove it
  through a change ticket. Never force-unlock while a run is active.

## Never
- Edit the state file by hand. Restore an older serial without step 4. Point a local test at the real backend.
