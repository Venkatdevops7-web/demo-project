data "aws_subnet" "private_subnets" {
  for_each = toset(var.private_subnets)
  id       = each.value
}

locals {
  subnet_id_by_az = { for subnet_id, subnet_values in data.aws_subnet.private_subnets : subnet_values.availability_zone => subnet_id }

  eks_managed_node_groups_with_placement = {
    for worker_group_name, worker_group_values in var.eks_managed_node_groups : worker_group_name => worker_group_values if try(worker_group_values.placement.availability_zone, null) != null
  }

  eks_managed_node_groups_with_placement_with_subnets = {
    for worker_group_name, worker_group_values in local.eks_managed_node_groups_with_placement : worker_group_name => merge(
      worker_group_values,
      {
        subnet_ids = [
          lookup(local.subnet_id_by_az, worker_group_values.placement.availability_zone)
        ]
      }
    )
  }

  eks_managed_node_groups = merge(var.eks_managed_node_groups, local.eks_managed_node_groups_with_placement_with_subnets)


}
