output "rds_endpoint" {
  description = "Connection endpoint of the RDS instance (private only)"
  value       = aws_db_instance.main.address
}

output "rds_port" {
  description = "Database port"
  value       = aws_db_instance.main.port
}

output "rds_arn" {
  description = "ARN of the RDS instance"
  value       = aws_db_instance.main.arn
}
