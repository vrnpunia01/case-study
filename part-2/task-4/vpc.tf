# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}
# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }
}

# Elastic-IP (eip) for NAT

resource "aws_eip" "nat" {
  vpc = true
 # instance                  = aws_instance.id
  associate_with_private_ip = "10.0.0.0/16"
  depends_on                = [aws_internet_gateway.ig]
  lifecycle {
    # prevent_destroy = true
  }
  tags = {
    Name        = "$environment-eip"
    Environment = var.environment
  }
}
 # NAT
 resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet.id

 
  tags = {
    Name        = "${var.environment}-nat"
    Environment = var.environment  }
}


# Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pblc_cidr_block
  availability_zone       = var.availability_zones
  map_public_ip_on_launch = true
  #depends_on = [aws_internet_gateway.gw]
  tags = {
    Name        = "${var.environment}-public-subnet"
    Environment = var.environment
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pvt_cidr_block
  availability_zone       = var.availability_zones
  map_public_ip_on_launch = false

  tags = {
    Name        = "$(var.availability_zones)-private-subnet"
    Environment = var.environment
  }
}

# Routing tables to route traffic for Private Subnet

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.environment}-private-route-table"
    Environment = var.environment
  }
}

  # Routing tables to route traffic for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.environment}-public-route-table"
   Environment = var.environment
  }
}

# Route for Internet Gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

# Route for NAT
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gw.id
}

# Route table associations for both Public & Private Subnets
resource "aws_route_table_association" "public" {
  for_each  = aws_subnet.public_subnet
  subnet_id = aws_subnet.public_subnet[each.key].id
 
  route_table_id = aws_route_table.public.id
}

# Private Route to Private Route Table for Private Subnets
resource "aws_route_table_association" "private" {
  for_each  = aws_subnet.private_subnet
  subnet_id = aws_subnet.private_subnet[each.key].id
 
  route_table_id = aws_route_table.private.id
}

