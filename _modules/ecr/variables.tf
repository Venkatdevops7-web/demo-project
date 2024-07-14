variable "repositories" {
  type        = set(string)
  description = "ECR repositories to create."
}

variable "name_prefix" {
  type = string
}
