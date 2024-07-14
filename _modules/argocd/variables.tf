variable "cluster_name" {
  description = "The cluster name."
  type        = string
}

variable "cluster_domain" {
  description = "The cluster domain."
  type        = string
}

variable "instances" {
  description = "Instances to be deployed."
  type        = map(map(string))
  default     = {}
}

variable "argo_instances" {
  description = "Instances to be deployed."
  type        = map(map(string))
  default     = {}
}

