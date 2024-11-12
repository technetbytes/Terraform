# Security Group
resource "aws_security_group" "two-tier-ec2-sg" {
  name        = "two-tier-ec2-sg"
  description = "Allow traffic from VPC"
  vpc_id      = aws_vpc.two-tier-vpc.id
  depends_on = [
    aws_vpc.two-tier-vpc
  ]

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
  }
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "two-tier-ec2-sg"
  }
}

# Load balancer security group
resource "aws_security_group" "two-tier-alb-sg" {
  name        = "two-tier-alb-sg"
  description = "load balancer security group"
  vpc_id      = aws_vpc.two-tier-vpc.id
  depends_on = [
    aws_vpc.two-tier-vpc
  ]


  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "two-tier-alb-sg"
  }
}

# Database tier Security gruop
resource "aws_security_group" "two-tier-db-sg" {
  name        = "two-tier-db-sg"
  description = "allow traffic from internet"
  vpc_id      = aws_vpc.two-tier-vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.two-tier-ec2-sg.id]
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.two-tier-ec2-sg.id]
    cidr_blocks     = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
