variable "db_master_password" {
  description = "Master password of the RDS instance (sensitive; provided by CI/CD secret store, never committed)"
  type        = string
  sensitive   = true
}
