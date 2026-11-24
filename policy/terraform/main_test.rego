package main

good_labels := {"environment": "dev", "owner": "devops", "component": "gke"}

cluster(loc) := {"resource_changes": [{"address": "c", "type": "google_container_cluster",
	"change": {"actions": ["create"], "after": {"location": loc, "resource_labels": good_labels}}}]}

fw(ranges, allow) := {"resource_changes": [{"address": "f", "type": "google_compute_firewall",
	"change": {"actions": ["create"], "after": {"source_ranges": ranges, "allow": allow}}}]}

test_zonal_cluster_allowed if {
	inp := cluster("asia-south1-a")
	count(deny) == 0 with input as inp
}

test_regional_cluster_denied if {
	inp := cluster("asia-south1")
	count(deny) == 1 with input as inp
}

test_open_allow_denied if {
	inp := fw(["0.0.0.0/0"], [{"protocol": "tcp"}])
	count(deny) == 1 with input as inp
}

test_open_deny_rule_allowed if {
	inp := fw(["0.0.0.0/0"], [])
	count(deny) == 0 with input as inp
}

test_iap_allow_allowed if {
	inp := fw(["35.235.240.0/20"], [{"protocol": "tcp", "ports": ["22"]}])
	count(deny) == 0 with input as inp
}

test_missing_labels_denied if {
	inp := {"resource_changes": [{"address": "r", "type": "google_artifact_registry_repository",
		"change": {"actions": ["create"], "after": {"labels": {"environment": "dev"}}}}]}
	count(deny) == 1 with input as inp
}

test_full_labels_allowed if {
	inp := {"resource_changes": [{"address": "r", "type": "google_secret_manager_secret",
		"change": {"actions": ["create"], "after": {"labels": good_labels}}}]}
	count(deny) == 0 with input as inp
}
