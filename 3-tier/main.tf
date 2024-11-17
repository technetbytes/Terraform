# Provider Configuration
provider "aws" {
  region = "us-west-2"  # Change to your AWS region
}
# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}
# Subnets
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"  # Change to your AWS availability zone
  map_public_ip_on_launch = true
}
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2a"  # Change to your AWS availability zone
}
# Security Groups
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow inbound traffic from the Internet to the web layer"
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
# ... (similar security groups for app and db layers)
# EC2 Instances for Web and App layers
resource "aws_instance" "web" {
  ami           = "ami-abcdefgh"  # Change to your AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.web_sg.id]
}
# ... (similar resource block for app layer)
# RDS Instance for DB layer
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
resource "aws_db_subnet_group" "default" {
  name       = "default"
  subnet_ids = [aws_subnet.private_subnet.id]
}