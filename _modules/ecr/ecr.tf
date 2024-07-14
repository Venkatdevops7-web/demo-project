resource "aws_ecr_repository" "application" {
  for_each             = var.repositories
  name                 = "${var.name_prefix}-${each.key}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
