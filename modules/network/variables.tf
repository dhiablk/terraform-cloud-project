variable "project_name" {
  description = "Project name used for resource naming and tags"
  type        = string

  validation {
    condition     = length(var.project_name) > 0 && length(var.project_name) <= 20
    error_message = "project_name must be between 1 and 20 characters."
  }
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be one of: dev, test, prod."
  }
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid IPv4 CIDR block."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks of the public subnets (one per AZ)"
  type        = list(string)
}

variable "app_subnet_cidrs" {
  description = "CIDR blocks of the private application subnets (one per AZ)"
  type        = list(string)
}

variable "db_subnet_cidrs" {
  description = "CIDR blocks of the private database subnets (one per AZ)"
  type        = list(string)
}

variable "azs" {
  description = "Availability zones to use"
  type        = list(string)
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}
