terraform {
  source = "${dirname(find_in_parent_folders())}/_modules/argocd///"
}

dependency "eks" {
  config_path = "../eks"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  cluster_name   = dependency.eks.outputs.cluster_name
  cluster_domain = local.environment_vars.locals.cluster_domain
  environment_name = local.environment_vars.locals.environment_name
}
