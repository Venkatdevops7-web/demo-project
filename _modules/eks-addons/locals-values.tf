locals {
  route53_arns = values(aws_route53_zone.cluster)[*].arn
}

locals {
  route53zone_id = values(aws_route53_zone.cluster)[*].zone_id
}