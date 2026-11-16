variable "project_name" {
  description = "Project name used for resource naming and tags"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the application servers"
  type        = string
  default     = "t3.micro"
}

variable "app_subnet_ids" {
  description = "Private application subnet IDs (one per AZ)"
  type        = list(string)

  validation {
    condition     = length(var.app_subnet_ids) >= 2
    error_message = "The ASG requires at least two app subnets (two AZs)."
  }
}

variable "app_security_group_id" {
  description = "Security group attached to the application instances"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile for the instances"
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN the ASG registers instances into"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances"
  type        = number
  default     = 2

  validation {
    condition     = var.min_size >= 2
    error_message = "min_size must be at least 2 (resilience requirement)."
  }
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
  default     = 4
}

variable "user_data" {
  description = "Base64-encoded user data script for the launch template"
  type        = string
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}
