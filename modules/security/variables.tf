variable "project_name" {
  description = "Project name used for resource naming and tags"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC where security groups are created"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC (used for internal rules)"
  type        = string
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "create_iam_role" {
  description = "Create the instance IAM role and profile (false on AWS Academy where iam:CreateRole is denied)"
  type        = bool
  default     = true
}
