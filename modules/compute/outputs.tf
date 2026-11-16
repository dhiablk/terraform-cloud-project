output "asg_name" {
  description = "Name of the Auto Scaling group"
  value       = aws_autoscaling_group.app.name
}

output "asg_arn" {
  description = "ARN of the Auto Scaling group"
  value       = aws_autoscaling_group.app.arn
}

output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.app.id
}

output "ami_id" {
  description = "AMI used by the launch template (Ubuntu 22.04, looked up via data source)"
  value       = data.aws_ami.ubuntu.id
}
