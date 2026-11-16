terraform {
  backend "s3" {
    bucket       = "cloud5-terraform-state-326553917564"
    key          = "prod/terraform.tfstate"
    region       = "eu-west-1"
    encrypt      = true
  }
}
