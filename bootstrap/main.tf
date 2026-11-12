# Bootstrap: creates the remote backend BEFORE the main project is initialized.
# Run once: terraform init && terraform apply
# The bucket is NOT part of the project state (no chicken-and-egg problem).

resource "aws_s3_bucket" "tfstate" {
  bucket = var.state_bucket_name

  tags = merge(var.tags, {
    Name    = var.state_bucket_name
    Purpose = "terraform-state"
  })
}

resource "aws_s3_bucket_public_access_block" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

output "bucket_name" {
  description = "Name of the state bucket to reference in backend blocks"
  value       = aws_s3_bucket.tfstate.bucket
}
