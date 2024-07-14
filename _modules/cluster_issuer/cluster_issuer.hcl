terraform {
  source = "${dirname(find_in_parent_folders())}/_modules/cluster_issuer///"
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
  aws_region         = local.environment_vars.locals.aws_region
  cluster_name       = dependency.eks.outputs.cluster_name
}