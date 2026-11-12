output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = [for s in aws_subnet.public : s.id]
}

output "app_subnet_ids" {
  description = "IDs of the private application subnets"
  value       = [for s in aws_subnet.app : s.id]
}

output "db_subnet_ids" {
  description = "IDs of the private database subnets"
  value       = [for s in aws_subnet.db : s.id]
}

output "azs" {
  description = "Availability zones actually used"
  value       = var.azs
}

output "nat_gateway_id" {
  description = "ID of the NAT gateway (controlled egress for private subnets)"
  value       = aws_nat_gateway.main.id
}

output "internet_gateway_id" {
  description = "ID of the Internet gateway"
  value       = aws_internet_gateway.main.id
}
