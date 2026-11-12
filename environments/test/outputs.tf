output "alb_url" {
  description = "URL of the load balancer"
  value       = "http://${module.load_balancer.alb_dns_name}"
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.load_balancer.alb_dns_name
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.network.public_subnet_ids
}

output "app_subnet_ids" {
  description = "Private app subnet IDs"
  value       = module.network.app_subnet_ids
}

output "db_subnet_ids" {
  description = "Private DB subnet IDs"
  value       = module.network.db_subnet_ids
}

output "asg_name" {
  description = "Auto Scaling group name"
  value       = module.compute.asg_name
}

output "rds_endpoint" {
  description = "RDS endpoint (private)"
  value       = module.database.rds_endpoint
}

output "assets_bucket" {
  description = "S3 bucket for assets/logs/backups"
  value       = module.storage.bucket_id
}
