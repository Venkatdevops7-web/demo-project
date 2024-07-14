module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.identifier

  engine               = var.engine
  engine_version       = var.engine_version
  family               = var.family                       # DB parameter group
  major_engine_version = var.major_engine_version         # DB option group
  instance_class       = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  db_name  = var.db_name
  username = var.db_username
  port     = var.db_port

  multi_az               = var.multi_az
  db_subnet_group_name   = aws_db_subnet_group.postgres_private.name
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window              = "Sun:20:30-Sun:22:30"
  backup_window                   = "19:00-20:00"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  create_cloudwatch_log_group     = true

  backup_retention_period = 10
  skip_final_snapshot     = true
  deletion_protection     = true
  auto_minor_version_upgrade = true

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60
  monitoring_role_name                  = var.monitoring_role_name
  monitoring_role_use_name_prefix       = true
  monitoring_role_description           = "RDS Monitoring role"
  iam_database_authentication_enabled   = true
  ca_cert_identifier                    = "rds-ca-ecc384-g1"
  apply_immediately                     = true

  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    },
    {
      name  = "log_connections"
      value = 1
    },
    {
      name  = "log_disconnections"
      value = 1
    },
    {
      name  = "log_error_verbosity"
      value = "verbose"
    },
    {
      name  = "log_statement"
      value = "mod"
    },
    {
      name  = "timezone"
      value = "Europe/Paris"
    }    
  ]

  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
}

resource "aws_db_subnet_group" "postgres_private" {
  name       = "${var.name_prefix}-${var.environment_name}-db-subnetgroup"
  subnet_ids = var.private_subnets

  tags = {
    Name = "Postgres DB subnet group"
  }
}
