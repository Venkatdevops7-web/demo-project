output "security_group_id" {
  value = module.security_group.security_group_id
}


output "db_address" {
  value = module.db.db_instance_address
}

output "db_endpoint" {
  value = module.db.db_instance_endpoint
}


output "db_port" {
  value = module.db.db_instance_port
}


output "db_secret_arn" {
  value = module.db.db_instance_master_user_secret_arn
}



