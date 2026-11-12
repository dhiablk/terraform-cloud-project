variable "project_name" {
  description = "Project name used for resource naming and tags"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC where the ALB is deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the ALB (at least two AZs)"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_ids) >= 2
    error_message = "The ALB requires at least two public subnets (high availability)."
  }
}

variable "alb_security_group_id" {
  description = "Security group attached to the ALB"
  type        = string
}

variable "health_check_path" {
  description = "Health check path for the target group"
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}
