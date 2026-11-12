variable "project_name" {
  description = "Project name used for resource naming and tags"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "db_subnet_ids" {
  description = "Private database subnet IDs (subnet group)"
  type        = list(string)

  validation {
    condition     = length(var.db_subnet_ids) >= 2
    error_message = "RDS requires a subnet group spanning at least two AZs."
  }
}

variable "db_security_group_id" {
  description = "Security group of the database (only reachable from app SG)"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username (not a secret; password comes from a secret manager)"
  type        = string
  default     = "dbadmin"
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 3306
}

variable "multi_az" {
  description = "Enable Multi-AZ for prod"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}
