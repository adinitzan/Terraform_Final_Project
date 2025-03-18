resource "aws_vpc" "VPC_AT" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC-AT",
    owner = "toharbarazi",
    Owner = "adibeker"
  }
}

# Create a Public Subnet
resource "aws_subnet" "public_subnet_AT" {
  vpc_id                  = aws_vpc.VPC_AT.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-AT",
    owner = "toharbarazi",
    Owner = "adibeker"
  }
}

# Create a Private Subnet
resource "aws_subnet" "private_subnet_AT" {
  vpc_id     = aws_vpc.VPC_AT.id
  cidr_block = var.private_subnet_cidr   
  availability_zone       = "us-east-1a"  # Change this to your preferred AZ
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet",
    owner = "toharbarazi",
    Owner = "adibeker"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw_AT" {
  vpc_id = aws_vpc.VPC_AT.id

  tags = {
    Name = "igw-AT"
    owner = "toharbarazi",
    Owner = "adibeker"
  }
}

# Create a Route Table for the public subnet (to route traffic to the internet)
resource "aws_route_table" "route_table_public_AT" {
  vpc_id = aws_vpc.VPC_AT.id
  tags = {
    Name = "public-route-table-AT",
    owner = "toharbarazi",
    Owner = "adibeker"
  }
}

# Create a Route in the Route Table for the public subnet (allowing internet access)
resource "aws_route" "route_public_AT" {
  route_table_id         = aws_route_table.route_table_public_AT.id
  destination_cidr_block = "0.0.0.0/0"  # This is the route for all traffic
  gateway_id             = aws_internet_gateway.igw_AT.id
}

# Associate the Route Table with the Public Subnet
resource "aws_route_table_association" "public_subnet_association_AT" {
  subnet_id      = aws_subnet.public_subnet_AT.id
  route_table_id = aws_route_table.route_table_public_AT.id
}

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip_AT" {
  domain = "vpc"  # Ensure the EIP is allocated in the VPC
}

resource "aws_nat_gateway" "nat_gateway_AT" {
  allocation_id = aws_eip.nat_eip_AT.id
  subnet_id     = aws_subnet.public_subnet_AT.id

  depends_on = [aws_internet_gateway.igw_AT] 

  tags = {
    Name = "nat-gateway-AT",
    owner = "toharbarazi",
    Owner = "adibeker"
  }
}

# Create a Route Table for the private subnet (to route traffic through the NAT Gateway)
resource "aws_route_table" "route_table_private_AT" {
  vpc_id = aws_vpc.VPC_AT.id
  tags = {
    Name = "private-route-table-AT",
    owner = "toharbarazi",
    Owner = "adibeker"
  }
}

# Create a Route in the Route Table for the private subnet (routing through the NAT Gateway)
resource "aws_route" "route_private_AT" {
  route_table_id         = aws_route_table.route_table_private_AT.id
  destination_cidr_block = "0.0.0.0/0"  # This is the route for all traffic
  nat_gateway_id         = aws_nat_gateway.nat_gateway_AT.id
}

# Associate the Route Table with the Private Subnet
resource "aws_route_table_association" "private_subnet_association_AT" {
  subnet_id      = aws_subnet.private_subnet_AT.id
  route_table_id = aws_route_table.route_table_private_AT.id
}
