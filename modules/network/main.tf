resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-vpc" })
}

# ---------------------------------------------------------------- subnets

resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.public_subnet_cidrs : idx => cidr }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = var.azs[tonumber(each.key)]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-public-${tonumber(each.key) + 1}"
    Tier = "public"
  })
}

resource "aws_subnet" "app" {
  for_each = { for idx, cidr in var.app_subnet_cidrs : idx => cidr }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = var.azs[tonumber(each.key)]

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-app-${tonumber(each.key) + 1}"
    Tier = "private-app"
  })
}

resource "aws_subnet" "db" {
  for_each = { for idx, cidr in var.db_subnet_cidrs : idx => cidr }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = var.azs[tonumber(each.key)]

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-db-${tonumber(each.key) + 1}"
    Tier = "private-db"
  })
}

# ------------------------------------------------------- internet gateway

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-igw" })
}

# ----------------------------------------------------------- nat gateway

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-nat-eip" })
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public)[0].id

  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-nat" })

  depends_on = [aws_internet_gateway.main]
}

# -------------------------------------------------------------- routing

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-rt-public" })
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "app" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-rt-app" })
}

resource "aws_route_table_association" "app" {
  for_each = aws_subnet.app

  subnet_id      = each.value.id
  route_table_id = aws_route_table.app.id
}

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-rt-db" })
}

resource "aws_route_table_association" "db" {
  for_each = aws_subnet.db

  subnet_id      = each.value.id
  route_table_id = aws_route_table.db.id
}
