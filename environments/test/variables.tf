variable "aws_region" {
  description = "Region of deployment"
  type        = string
  default     = "eu-west-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "test"
}

variable "project_name" {
  description = "Project prefix for naming"
  type        = string
  default     = "cloud5"
}

variable "owner" {
  description = "Owner used in tags"
  type        = string
  default     = "dhiablk"
}

variable "vpc_cidr" {
  description = "Main network block"
  type        = string
  default     = "10.20.0.0/16"

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid IPv4 CIDR."
  }
}

variable "public_subnet_cidrs" {
  description = "Public subnets (ALB)"
  type        = list(string)
  default     = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "app_subnet_cidrs" {
  description = "Private application subnets"
  type        = list(string)
  default     = ["10.20.11.0/24", "10.20.12.0/24"]
}

variable "db_subnet_cidrs" {
  description = "Private database subnets"
  type        = list(string)
  default     = ["10.20.21.0/24", "10.20.22.0/24"]
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "ASG minimum size"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "ASG maximum size"
  type        = number
  default     = 4
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_master_password" {
  description = "RDS master password (from CI/CD secret store or TF_VAR, never in Git)"
  type        = string
  sensitive   = true
}
