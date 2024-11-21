# Load balancer security group - 1
resource "aws_security_group" "three-tier-alb-sg-1" {
  name        = "three-tier-alb-sg-1"
  description = "load balancer security group for web tier"
  vpc_id      = aws_vpc.three-tier-vpc.id
  depends_on = [
    aws_vpc.three-tier-vpc
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
    Name = "three-tier-alb-sg-1"
  }
}

# Load balancer security group - 2 - app
resource "aws_security_group" "three-tier-alb-sg-2" {
  name        = "three-tier-alb-sg-2"
  description = "load balancer security group for app tier"
  vpc_id      = aws_vpc.three-tier-vpc.id
  depends_on = [
    aws_vpc.three-tier-vpc
  ]

  ingress {
    from_port          = "80"
    to_port            = "80"
    protocol           = "tcp"
    security_groups    = [aws_security_group.three-tier-alb-sg-1.id]
  }

  tags = {
    Name = "three-tier-alb-sg-2"
  }
}
#################################################################################################################################################

# web tier auto scalling group - Security Group
resource "aws_security_group" "three-tier-ec2-asg-sg" {
  name        = "three-tier-ec2-asg-sg"
  description = "Allow traffic from VPC"
  vpc_id      = aws_vpc.three-tier-vpc.id
  depends_on = [
    aws_vpc.three-tier-vpc
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
    Name = "three-tier-ec2-asg-sg"
  }
}

# app tier auto scalling group - Security Group
resource "aws_security_group" "three-tier-ec2-asg-sg-app" {
  name        = "three-tier-ec2-asg-sg-app"
  description = "Allow traffic from web tier"
  vpc_id      = aws_vpc.three-tier-vpc.id
  depends_on = [
    aws_vpc.three-tier-vpc
  ]

  ingress {
    from_port = "-1"
    to_port   = "-1"
    protocol  = "icmp"
    security_groups  = [aws_security_group.three-tier-ec2-asg-sg.id]
  }
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    security_groups  = [aws_security_group.three-tier-ec2-asg-sg.id]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    security_groups  = [aws_security_group.three-tier-ec2-asg-sg.id]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "three-tier-ec2-asg-sg-app"
  }
}

#####################################################################################################################

# Database tier Security gruop
resource "aws_security_group" "three-tier-db-sg" {
  name        = "three-tier-db-sg"
  description = "allow traffic from app tier"
  vpc_id      = aws_vpc.three-tier-vpc.id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["192.168.0.128/27" , "192.168.0.160/27"]
    description      = "Access for the web ALB SG"
    #security_groups = [aws_security_group.prlw-webalb-sg.id]
  }


  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.three-tier-ec2-asg-sg-app.id]
    cidr_blocks     = ["192.168.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
