terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  eks_cluster_name = local.environment_vars.locals.eks_cluster_name
}

inputs = {
  name                 = "${local.environment_vars.locals.name_prefix}-vpc"
  enable_nat_gateway   = true
  single_nat_gateway   = false
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                          = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"                 = "1"
  }
}
