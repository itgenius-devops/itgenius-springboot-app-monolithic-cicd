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

output "prometheus_server_public_ip" {
  description = "The public IP address of the Prometheus server"
  value       = aws_instance.prometheus_server.public_ip
}

output "grafana_server_public_ip" {
  description = "The public IP address of the Grafana server"
  value       = aws_instance.grafana_server.public_ip
}

output "monolithic_server_public_ip" {
  description = "The public IP address of the Monolithic server"
  value       = aws_instance.monolithic_server.public_ip
}

output "nexus_server_public_ip" {
  description = "The public IP address of the Nexus server"
  value       = aws_instance.nexus_server.public_ip
}

output "sonarqube_server_public_ip" {
  description = "The public IP address of the SonarQube server"
  value       = aws_instance.sonarqube_server.public_ip
}

output "db_instance_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.itgenius_instance.endpoint
}

output "db_instance_port" {
  description = "The port of the RDS instance"
  value       = aws_db_instance.itgenius_instance.port
}

output "db_instance_address" {
  description = "The DNS address of the RDS instance"
  value       = aws_db_instance.itgenius_instance.address
}
