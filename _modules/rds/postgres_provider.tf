locals {
  postgres_identifier    = module.db.db_instance_address
  postgres_user_name     = module.db.db_instance_username
  postgres_db_password   = lookup(jsondecode(sensitive(data.aws_secretsmanager_secret_version.current.secret_string)), "password")
  postgres_port          = module.db.db_instance_port
}

provider "postgresql" {
  host            = local.postgres_identifier
  port            = local.postgres_port
  username        = local.postgres_user_name
  password        = local.postgres_db_password
  superuser       = "false"
}


provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}