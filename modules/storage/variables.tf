variable "project_name" {
  description = "Project name used for resource naming and tags"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "bucket_name" {
  description = "Unique global bucket name"
  type        = string
}

variable "force_destroy" {
  description = "Allow bucket deletion even if not empty (dev/test only)"
  type        = bool
  default     = false
}

variable "transition_to_ia_days" {
  description = "Days before objects transition to STANDARD_IA"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}
