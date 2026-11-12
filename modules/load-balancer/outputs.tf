output "alb_dns_name" {
  description = "Public DNS name of the ALB (entry point of the application)"
  value       = aws_lb.main.dns_name
}

output "target_group_arn" {
  description = "ARN of the target group used by the Auto Scaling group"
  value       = aws_lb_target_group.app.arn
}

output "listener_arn" {
  description = "ARN of the HTTP listener"
  value       = aws_lb_listener.http.arn
}
