# Provider Configuration
provider "aws" {
  region = "ap-southeast-1"
}

# VPC section
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Internet Gateway section
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# public subnets section
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-1"  
  map_public_ip_on_launch = true
}

# private subnets section
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-southeast-1"  
}

# Security Groups
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow Internet inbound traffic to the web layer"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

# EC2 Instances for Frontend and Application
resource "aws_instance" "web" {
  ami           = "ami-3525f453"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.web_sg.id]
}

# RDS Instance for MySQL database
resource "aws_db_instance" "default" {
  identifier        = "my-database"
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t2.micro"
  name              = "mydb"
  username          = "admin"
  password          = "password"
  allocated_storage = 20
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  subnet_group_name      = aws_db_subnet_group.default.name
}

# Db Subnet Groups
resource "aws_db_subnet_group" "default" {
  name       = "default"
  subnet_ids = [aws_subnet.private_subnet.id]
}