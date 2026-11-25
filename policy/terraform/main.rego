# KAVERI policies on the Terraform plan JSON (conftest test plan.json -p policy/terraform).
package main

changing(rc) if {
	some a in rc.change.actions
	a in {"create", "update"}
}

zonal(loc) if regex.match(`^[a-z]+-[a-z]+[0-9]+-[a-z]$`, loc)

# P1: DEV GKE must be zonal (ADR-0006).
deny contains msg if {
	some rc in input.resource_changes
	rc.type == "google_container_cluster"
	changing(rc)
	not zonal(rc.change.after.location)
	msg := sprintf("P1 %s: GKE location %q is not a zone - DEV must be zonal (ADR-0006)", [rc.address, rc.change.after.location])
}

# P2: no firewall ALLOW from the whole internet.
deny contains msg if {
	some rc in input.resource_changes
	rc.type == "google_compute_firewall"
	changing(rc)
	"0.0.0.0/0" in rc.change.after.source_ranges
	count(rc.change.after.allow) > 0
	msg := sprintf("P2 %s: firewall ALLOW from 0.0.0.0/0 is forbidden", [rc.address])
}

# P3: required cost labels (FinOps, #16).
required_labels := {"environment", "owner", "component"}

label_attr := {
	"google_container_cluster": "resource_labels",
	"google_artifact_registry_repository": "labels",
	"google_secret_manager_secret": "labels",
}

deny contains msg if {
	some rc in input.resource_changes
	attr := label_attr[rc.type]
	changing(rc)
	labels := object.get(rc.change.after, attr, {})
	present := {k | some k, _ in labels}
	missing := required_labels - present
	count(missing) > 0
	msg := sprintf("P3 %s: missing required labels %v", [rc.address, sort(missing)])
}

# P4: a private endpoint requires master authorized networks (GKE API rule; terraform plan cannot detect it).
man_enabled(after) if count(after.master_authorized_networks_config) > 0

deny contains msg if {
	some rc in input.resource_changes
	rc.type == "google_container_cluster"
	changing(rc)
	some pcc in rc.change.after.private_cluster_config
	pcc.enable_private_endpoint == true
	not man_enabled(rc.change.after)
	msg := sprintf("P4 %s: private endpoint requires master_authorized_networks_config (GKE rejects it at apply)", [rc.address])
}

# P5: no delete/replace of protected DEV resources unless the address is in the reviewed allowlist (#61, P2-10).
protected_types := {"google_container_cluster", "google_container_node_pool", "google_compute_network", "google_compute_subnetwork"}

replace_allowed := {a | some a in data.replace_allowlist.addresses}

deny contains msg if {
	some rc in input.resource_changes
	rc.type in protected_types
	"delete" in rc.change.actions
	not replace_allowed[rc.address]
	msg := sprintf("P5 %s: plan would %v a protected DEV resource - add it to policy/terraform/data/replace_allowlist.json in a reviewed PR if intended", [rc.address, rc.change.actions])
}
