locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment_name = local.environment_vars.locals.environment_name
  aws_account_id   = local.environment_vars.locals.aws_account_id
  aws_region       = local.environment_vars.locals.aws_region
  name_prefix      = local.environment_vars.locals.name_prefix
  s3_state_bucket  = "${local.name_prefix}-terraform-state-s3"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "aws" {
      region = "${local.aws_region}"
      allowed_account_ids = ["${local.aws_account_id}"]
    }
  EOF
}


remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket          = "${local.s3_state_bucket}"
    key            = "${local.aws_account_id}-${local.name_prefix}/${local.aws_region}/${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "${local.aws_account_id}-${local.name_prefix}-terraform-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(
  local.environment_vars.locals,
)
