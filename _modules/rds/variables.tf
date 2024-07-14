variable "rds_postgresql_instance_defaults" {
  type    = any
  default = {}
}

variable "identifier" {
  type = string
}

variable "rds_instance_name" {
  type = string
}

variable engine {
  type = string
}

variable engine_version {
  type = string
}

variable "family" {
  type = string
}

variable "major_engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "max_allocated_storage" {
  type = number
}

variable "storage_type" {
  type = string
}

variable "storage_encrypted" {
  type = bool
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_port" {
  type = number
}


variable "security_group_name" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "multi_az" {
  type = bool
  default = false
}

variable "name_prefix" {
  type = string
}

variable "monitoring_role_name" {
  type = string
}

variable "db_schema" {
  type        = map(map(string))
  description = "DB Schema to create."
  default     = {}
}

variable "environment_name" {
  type = string
}

variable "cluster_name" {
  description = "The cluster name."
  type        = string
}

variable "instances" {
  description = "Instances to be deployed."
  type        = map(map(string))
  default     = {}
}