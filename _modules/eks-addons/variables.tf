variable "cluster_name" {
  description = "The cluster name."
  type        = string
}

variable "vpc_id" {
  description = "The cluster name."
  type        = string
}

variable "cluster_domain" {
  description = "The cluster domain."
  type        = string
}

variable "name_prefix" {
  description = "The name prefix for all AWS resources."
  type        = string
}

variable "oidc_provider_arn" {
  description = "The OIDC provider ARN of the EKS cluster."
  type        = string
}

variable "role_name" {
  description = "The OIDC provider ARN of the EKS cluster."
  type        = string
}

variable "aws_region" {
  description = "The AWS region."
  type        = string
}

variable "applications_chart" {
  description = "The path to the applications Helm chart."
  type        = string
}

variable "environment_name" {
  description = "The environment name."
  type        = string
}

variable "base_repo_url" {
  description = "The base repo URL."
  type        = string
}

variable "main_instance_prefix" {
  description = "The main instance prefix."
  type        = string
  default     = ""
}

variable "instances" {
  description = "Instances to be deployed."
  type        = map(map(string))
  default     = {}
}

variable "GITHUB_TOKEN" {
  description = "The main instance prefix."
  type        = string
  default     = ""
}

variable "GITHUB_USERNAME" {
  description = "The main instance prefix."
  type        = string
  default     = ""
}

variable "Imperva_IAM_Access_Key" {
  description = "The main instance prefix."
  type        = string
  default     = ""
}

variable "Imperva_IAM_Secret_Key" {
  description = "The main instance prefix."
  type        = string
  default     = ""
}

variable "Imperva_region" {
  description = "The main instance prefix."
  type        = string
  default     = ""
}


variable "Imperva_Terragrunt_Image" {
  description = "The main instance prefix."
  type        = string
  default     = ""
}

# Database configuration

# variable "db_address" {
#   description = "RDS Database Address"
#   type        = string
# }

# variable "db_port" {
#   description = "RDS Database Addres Port"
#   type        = string
# }

# variable "db_schema" {
#   description = "RDS Database Schema names"
#   type        = map(string)
# }

# variable "db_username" {
#   description = "RDS Database Schema names"
#   type        = map(string)
# }

# variable "db_password" {
#   description = "RDS Database Schema Passwords"
#   type        = map(string)
# }


