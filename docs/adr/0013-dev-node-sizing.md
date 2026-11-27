# ADR-0013: DEV node sizing - dedicated Spot application node pool

- Status: Accepted
- Phase 2, before step 2.15

## Context
DEV runs a zonal private GKE cluster with one pool, kaveri-dev-system-pool (e2-medium, autoscaling 1-2). With only system workloads it already uses around 90% of the allocatable CPU of an e2-medium node, so Online Boutique cannot be scheduled. Changing the machine type of the existing pool forces a node-pool replacement, which policy P5 blocks unless allowlisted and which would interrupt system workloads during the swap.

## Decision
1. Keep kaveri-dev-system-pool unchanged (e2-medium, 1-2 nodes) for kube-system and platform add-ons.
2. Add kaveri-dev-app-pool: e2-standard-2 (2 vCPU, 8 GB), Spot, autoscaling 1-2, zone asia-south1-a, with the same hardening as the system pool (shielded nodes, GKE metadata server, dedicated node SA, COS_CONTAINERD).
3. The gke module gains an optional spot attribute (default false), so existing pools are unchanged.
4. dev-pause v3 scales every node pool to zero instead of one hard-coded pool. Resume stays terraform-apply-dev, which restores autoscaling on all pools.
5. DEV deploys the core Online Boutique services; shoppingassistantservice (needs AlloyDB and Gemini) and loadgenerator stay out until needed.

## Alternatives considered
- Resize the existing pool to a larger machine type: replacement (P5) and downtime for system pods. Rejected.
- Larger on-demand pool: several times the Spot price for an environment that is paused most of the time. Rejected for DEV; PROD will use on-demand capacity.
- GKE Autopilot: a different cluster mode that would mean rebuilding DEV. Deferred.

## Consequences
- Spot nodes can be preempted with about 30 s notice; acceptable for DEV because workloads reschedule. Not used for UAT/PROD.
- Awake DEV cost rises by one e2-standard-2 Spot VM (estimate; verify in Billing reports, Infracost in #56).
- Change-window plan: 1 to add (app pool), 4 to change (system-pool autoscaling restore, two alert policies, registry cleanup policies), 0 to destroy.

## Workload requests (from kaveri-boutique kubernetes manifests)

```
adservice                  x1  cpu=0.200  mem=180Mi
cartservice                x1  cpu=0.200  mem=64Mi
checkoutservice            x1  cpu=0.100  mem=64Mi
currencyservice            x1  cpu=0.100  mem=64Mi
emailservice               x1  cpu=0.100  mem=64Mi
frontend                   x1  cpu=0.100  mem=64Mi
loadgenerator              x1  cpu=0.300  mem=256Mi (optional, excluded in DEV)
paymentservice             x1  cpu=0.100  mem=64Mi
productcatalogservice      x1  cpu=0.100  mem=64Mi
recommendationservice      x1  cpu=0.100  mem=220Mi
redis-cart                 x1  cpu=0.070  mem=200Mi
shippingservice            x1  cpu=0.100  mem=64Mi
TOTAL all  : cpu=1.570 vCPU  mem=1368Mi
TOTAL core : cpu=1.270 vCPU  mem=1112Mi
```
