resource "aws_route53_zone" "cluster" {
  for_each = var.instances
  name = "${try(each.value.root_instance, false) ? var.cluster_domain : join(".", [each.key, var.cluster_domain])}"
}
