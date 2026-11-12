terraform {
  backend "s3" {
    bucket       = "cloud5-terraform-state"
    key          = "dev/terraform.tfstate"
    region       = "eu-west-1"
    encrypt      = true
    use_lockfile = true
  }
}
