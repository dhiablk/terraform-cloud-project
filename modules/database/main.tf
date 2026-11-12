resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-${var.environment}-dbsubnetgroup"
  subnet_ids = var.db_subnet_ids

  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-dbsubnetgroup" })
}

# Master password is NOT stored in Git: it is read from the CI/CD secret
# store (or from SSM Parameter Store) at plan/apply time.
resource "aws_db_instance" "main" {
  identifier     = "${var.project_name}-${var.environment}-rds"
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = var.db_instance_class

  allocated_storage = 20
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_master_password
  port     = var.db_port

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.db_security_group_id]

  multi_az               = var.multi_az
  publicly_accessible    = false
  skip_final_snapshot    = var.environment != "prod"
  deletion_protection    = var.environment == "prod"
  backup_retention_period = var.environment == "prod" ? 14 : 1

  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-rds" })
}
