include "root" {
  path = find_in_parent_folders()
}

include "modules" {
  path = "${dirname(find_in_parent_folders())}/_modules/eks/eks.hcl"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment_name = local.environment_vars.locals.environment_name
  aws_region       = local.environment_vars.locals.aws_region
}

inputs = {

  cluster_endpoint_public_access = true
  eks_cluster_version = 1.29
  
  eks_managed_node_group_defaults = {
    ami_type       = "BOTTLEROCKET_x86_64"
    platform       = "bottlerocket"
    instance_types = ["t2.large"]
    block_device_mappings = {
      xvda = {
        device_name = "/dev/xvda"
        ebs = {
          volume_size           = 2
          volume_type           = "gp2"
          encrypted             = true
          delete_on_termination = true
        }
      }
      xvdb = {
        device_name = "/dev/xvdb"
        ebs = {
          volume_size           = 20
          volume_type           = "gp2"
          encrypted             = true
          delete_on_termination = true
        }
      }
    }
  }

  eks_managed_node_groups = {
    worker_group_on_demand_ap_south_1a = {
      name         = "on-demand-1a"
      min_size     = 0
      desired_size = 1
      max_size     = 2

      placement = {
        availability_zone = "${local.aws_region}a"
      }
    }

    // worker_group_on_demand_ap_south_1b = {
    //   name         = "on-demand-1b"
    //   min_size     = 0
    //   desired_size = 1
    //   max_size     = 2

    //   placement = {
    //     availability_zone = "${local.aws_region}b"
    //   }
    // }

    // worker_group_on_demand_ap_south_1c = {
    //   name         = "on-demand-1c"
    //   min_size     = 0
    //   desired_size = 1
    //   max_size     = 2

    //   placement = {
    //     availability_zone = "eu-central-1c"
    //   }
    // }
  }

  manage_aws_auth_configmap = false

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::211125729272:user/NitishAdmin"
      username = "NitishAdmin"
      groups   = ["system:masters"]
    },
  ]
}
