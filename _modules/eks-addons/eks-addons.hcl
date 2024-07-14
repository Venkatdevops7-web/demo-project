terraform {
  source = "${dirname(find_in_parent_folders())}/_modules/eks-addons///"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "eks" {
  config_path = "../eks"
}

dependency "argocd" {
  config_path  = "../argocd"
  skip_outputs = true
}


locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  
}

inputs = {
  cluster_name       = dependency.eks.outputs.cluster_name
  oidc_provider_arn  = dependency.eks.outputs.oidc_provider_arn
  aws_region         = local.environment_vars.locals.aws_region
  name_prefix        = local.environment_vars.locals.name_prefix
  cluster_domain     = local.environment_vars.locals.cluster_domain
  environment_name   = local.environment_vars.locals.environment_name
  base_repo_url      = local.environment_vars.locals.base_repo_url
  applications_chart = "${dirname(find_in_parent_folders())}/applications/base-manifests"
  instances          = local.environment_vars.locals.instances
  role_name          = "hays-tbw-poc-eks-cluster-terraform"
  vpc_id             = dependency.vpc.outputs.vpc_id
}
