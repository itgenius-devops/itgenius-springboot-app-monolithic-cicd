output "rds_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.itgenius_instance.endpoint
}

output "rds_instance_id" {
  description = "The identifier of the RDS instance"
  value       = aws_db_instance.itgenius_instance.id
}

output "security_group_id" {
  description = "The security group ID for the RDS instance"
  value       = aws_security_group.itgenius_sg.id
}