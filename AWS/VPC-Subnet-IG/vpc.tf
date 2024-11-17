## Null label for VPC 
module "label-technet-vpc" {
  source = "cloudposse/label/null"

  namespace   = var.project
  environment = var.environment
  name        = "vpc"

  label_order = ["namespace", "name", "environment"]

  additional_tag_map = {
    ManagedBy = "Terraform"
  }
}

## VPC
resource "aws_vpc" "technet-vpc" {
  cidr_block       = var.vpc-cidr-block
  instance_tenancy = "default"
  tags = {
    Name = "${module.label-technet-vpc.id}"
  }
}

## VPC Internet Gateway
resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.technet-vpc.id
  tags = {
    Name = "${var.project}-IGW"
  }
}

## Elastic IP for NAT Gateway
resource "aws_eip" "nat-gateway-eip" {
  vpc = true
  tags = {
    Name = "${var.project}-nat-gateway-eip"
  }
}

## VPC NAT(Network Address Translation) Gateway
resource "aws_nat_gateway" "vpc-nat-gateway" {
  allocation_id = aws_eip.nat-gateway-eip.id
  subnet_id     = aws_subnet.vpc-public-subnet-1.id
  tags = {
    Name = "${var.project}-nat-gateway"
  }
}

##########################
## Public Subnets
##########################

############# Public Subnet 1 #############
## Public Subnet 1
resource "aws_subnet" "vpc-public-subnet-1" {
  vpc_id            = aws_vpc.technet-vpc.id
  cidr_block        = var.public-subnet-1-cidr-block
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.project}-public-subnet-01"
  }
}

## Route Table for Public Subnet 1
resource "aws_route_table" "public-subnet-1-rtb" {
  vpc_id = aws_vpc.technet-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-igw.id
  }
  tags = {
    Name = "${var.project}-rtb-public-subnet-01"
  }
}

## Route Table Association for Public Subnet 1
resource "aws_route_table_association" "public-subnet-1-rtb-association" {
  subnet_id      = aws_subnet.vpc-public-subnet-1.id
  route_table_id = aws_route_table.public-subnet-1-rtb.id
}


############# Public Subnet 2 #############
## Public Subnet 2
resource "aws_subnet" "vpc-public-subnet-2" {
  vpc_id            = aws_vpc.technet-vpc.id
  cidr_block        = var.public-subnet-2-cidr-block
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.project}-public-subnet-02"
  }
}

## Route Table for Public Subnet 1
resource "aws_route_table" "public-subnet-2-rtb" {
  vpc_id = aws_vpc.technet-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-igw.id
  }
  tags = {
    Name = "${var.project}-rtb-public-subnet-02"
  }
}

## Route Table Association for Public Subnet 1
resource "aws_route_table_association" "public-subnet-2-rtb-association" {
  subnet_id      = aws_subnet.vpc-public-subnet-2.id
  route_table_id = aws_route_table.public-subnet-2-rtb.id
}


############# Public Subnet 3 #############
## Public Subnet 3
resource "aws_subnet" "vpc-public-subnet-3" {
  vpc_id            = aws_vpc.technet-vpc.id
  cidr_block        = var.public-subnet-3-cidr-block
  availability_zone = "${var.region}c"
  tags = {
    Name = "${var.project}-public-subnet-03"
  }
}

## Route Table for Public Subnet 3
resource "aws_route_table" "public-subnet-3-rtb" {
  vpc_id = aws_vpc.technet-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-igw.id
  }
  tags = {
    Name = "${var.project}-rtb-public-subnet-03"
  }
}

## Route Table Association for Public Subnet 1
resource "aws_route_table_association" "public-subnet-3-rtb-association" {
  subnet_id      = aws_subnet.vpc-public-subnet-3.id
  route_table_id = aws_route_table.public-subnet-3-rtb.id
}


##########################
## Private Subnets
##########################

############# Private Subnet 1 #############
## Private Subnet 1
resource "aws_subnet" "vpc-private-subnet-1" {
  vpc_id            = aws_vpc.technet-vpc.id
  cidr_block        = var.private-subnet-1-cidr-block
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.project}-private-subnet-01"
  }
}

## Route Table for Private Subnet 1
resource "aws_route_table" "private-subnet-1-rtb" {
  vpc_id = aws_vpc.technet-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vpc-nat-gateway.id
  }
  tags = {
    Name = "${var.project}-rtb-private-subnet-01"
  }
}

## Route Table Association for Private Subnet 1
resource "aws_route_table_association" "private-subnet-1-rtb-association" {
  subnet_id      = aws_subnet.vpc-private-subnet-1.id
  route_table_id = aws_route_table.private-subnet-1-rtb.id
}


############# Private Subnet 2 #############
## Private Subnet 2
resource "aws_subnet" "vpc-private-subnet-2" {
  vpc_id            = aws_vpc.technet-vpc.id
  cidr_block        = var.private-subnet-2-cidr-block
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.project}-private-subnet-02"
  }
}

## Route Table for Private Subnet 2
resource "aws_route_table" "private-subnet-2-rtb" {
  vpc_id = aws_vpc.technet-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vpc-nat-gateway.id
  }
  tags = {
    Name = "${var.project}-rtb-private-subnet-02"
  }
}

## Route Table Association for Private Subnet 2
resource "aws_route_table_association" "private-subnet-2-rtb-association" {
  subnet_id      = aws_subnet.vpc-private-subnet-2.id
  route_table_id = aws_route_table.private-subnet-2-rtb.id
}


############# Private Subnet 3 #############
## Private Subnet 3
resource "aws_subnet" "vpc-private-subnet-3" {
  vpc_id            = aws_vpc.technet-vpc.id
  cidr_block        = var.private-subnet-3-cidr-block
  availability_zone = "${var.region}c"
  tags = {
    Name = "${var.project}-private-subnet-03"
  }
}

## Route Table for Private Subnet 3
resource "aws_route_table" "private-subnet-3-rtb" {
  vpc_id = aws_vpc.technet-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vpc-nat-gateway.id
  }
  tags = {
    Name = "${var.project}-rtb-private-subnet-03"
  }
}

## Route Table Association for Private Subnet 3
resource "aws_route_table_association" "private-subnet-3-rtb-association" {
  subnet_id      = aws_subnet.vpc-private-subnet-3.id
  route_table_id = aws_route_table.private-subnet-3-rtb.id
}