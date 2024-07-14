variable "eks_cluster_name" {
  type = string
}

variable "eks_cluster_version" {
  type = string
}

variable "cluster_endpoint_public_access" {
  type = bool
  default = false
}

variable "environment_name" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "eks_managed_node_group_defaults" {
  type    = any
  default = {}
}

variable "eks_managed_node_groups" {
  type    = any
  default = {}
}

variable "aws_auth_roles" {
  type    = list(any)
  default = []
}

variable "aws_auth_users" {
  type    = list(any)
  default = []
}

variable "aws_auth_accounts" {
  type    = list(string)
  default = []
}

variable "manage_aws_auth_configmap" {
  type    = bool
  default = false
}

variable "github_role_arns" {
  type    = list(string)
  default = []
}
