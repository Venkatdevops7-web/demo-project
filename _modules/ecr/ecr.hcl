terraform {
  source = "${dirname(find_in_parent_folders())}/_modules/ecr///"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  repositories = local.environment_vars.locals.repositories
  name_prefix  = local.environment_vars.locals.name_prefix
}
