include "root" {
  path = find_in_parent_folders()
}

include "modules" {
  path = "${dirname(find_in_parent_folders())}/_modules/rds/rds.hcl"
}

inputs = {
  # DB Engine Configuration
  engine                    = "postgres"
  family                    = "postgres15"
  engine_version            = "15.5" 
  major_engine_version      = "15"
  instance_class            = "db.t4g.small"
  allocated_storage         = 10
  max_allocated_storage     = 50
  multi_az                  = false
  storage_type              = "gp2"
  storage_encrypted         = true

# DB Instance Configuration
  db_name                   = "demodevpostgres"
  db_username               = "devdbroot"
  db_port                   = 5210

  identifier                = "demodevrds"
  rds_instance_name         = "demodevrds"
  security_group_name       = "demo-dev-rds-sg"
  monitoring_role_name      = "demo-dev-rds-role-iam"

}