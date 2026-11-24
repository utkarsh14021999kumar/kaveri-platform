locals {
  # Zonal when var.location is a zone; regional (backward compatible) when null.
  location = coalesce(var.location, var.region)
}
