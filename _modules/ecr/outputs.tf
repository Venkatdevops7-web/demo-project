output "ecr_repositories_arns" {
  value = [for repo in aws_ecr_repository.application : repo.arn]
}
