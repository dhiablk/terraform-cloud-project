variable "aws_region" {
  description = "Region hosting the Terraform state bucket"
  type        = string
  default     = "eu-west-1"
}

variable "state_bucket_name" {
  description = "Unique global name of the Terraform state bucket"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
