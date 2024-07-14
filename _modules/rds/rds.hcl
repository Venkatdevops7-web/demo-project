terraform {
  source = "${dirname(find_in_parent_folders())}/_modules/rds///"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "eks" {
  config_path = "../eks"

}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  cluster_name     = dependency.eks.outputs.cluster_name
  eks_cluster_name = local.environment_vars.locals.eks_cluster_name
  name_prefix      = local.environment_vars.locals.name_prefix
  private_subnets  = dependency.vpc.outputs.private_subnets
  vpc_id           = dependency.vpc.outputs.vpc_id
  environment_name = local.environment_vars.locals.environment_name
  instances        = local.environment_vars.locals.instances

}
