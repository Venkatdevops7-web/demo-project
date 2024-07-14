include "root" {
  path = find_in_parent_folders()
}

include "modules" {
  path = "${dirname(find_in_parent_folders())}/_modules/cluster_issuer/cluster_issuer.hcl"
}

