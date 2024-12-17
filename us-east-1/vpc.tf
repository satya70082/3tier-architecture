locals {
  project = "3tierproject"
}

# VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a" # Change as per region
  tags = {
    Name = "${local.project}-public-subnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "${local.project}-public-subnet2"
  }
}

#internet gateway 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "${local.project}-igw"
  }
}
# Route Table for Public Subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "${local.project}-public-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
#attach public subnet1 to route table
resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_rt.id
  
}
#attach public subnet2 to route table
resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_rt.id
}
# Private Subnets
resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "${local.project}-private-subnet1"
  }
}
resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "${local.project}-private-subnet2"
  }
  
}
resource "aws_subnet" "private_subnet3" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "${local.project}-private-subnet3"
  }
  
}
resource "aws_subnet" "private_subnet4" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "${local.project}-private-subnet4"
  }
}
resource "aws_subnet" "private_subnet5" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "${local.project}-private-subnet5"
  }
  
}
resource "aws_subnet" "private_subnet6" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.7.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "${local.project}-private-subnet6"
  }
}
#elastic ip
resource "aws_eip" "eip" {
}
#nat gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet1.id
  tags = {
    Name = "${local.project}-nat-gateway"
  }
}
# Route Table for Private Subnets
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "${local.project}-private-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}
#attach private subnet1 to route table
resource "aws_route_table_association" "private_subnet1_association" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_rt.id
}
#attach private subnet2 to route table
resource "aws_route_table_association" "private_subnet2_association" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_rt.id
}
#attach private subnet3 to route table
resource "aws_route_table_association" "private_subnet3_association" {
  subnet_id      = aws_subnet.private_subnet3.id
  route_table_id = aws_route_table.private_rt.id
}
#attach private subnet4 to route table
resource "aws_route_table_association" "private_subnet4_association" {
  subnet_id      = aws_subnet.private_subnet4.id
  route_table_id = aws_route_table.private_rt.id
}
#attach private subnet5 to route table
resource "aws_route_table_association" "private_subnet5_association" {
  subnet_id      = aws_subnet.private_subnet5.id
  route_table_id = aws_route_table.private_rt.id
}
#attach private subnet6 to route table
resource "aws_route_table_association" "private_subnet6_association" {
  subnet_id      = aws_subnet.private_subnet6.id
  route_table_id = aws_route_table.private_rt.id
}

