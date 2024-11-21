# VPC
resource "aws_vpc" "three-tier-vpc" {
  cidr_block = "192.168.0.0/24"
  tags = {
    Name = "three-tier-vpc"
  }
}

# Public Subnets 
resource "aws_subnet" "three-tier-pub-sub-1" {
  vpc_id            = aws_vpc.three-tier-vpc.id
  cidr_block        = "192.168.0.0/26"  # Public Subnet 1: 192.168.0.0/26 (64 IPs, 0-63).
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "three-tier-pub-sub-1"
  }
}

resource "aws_subnet" "three-tier-pub-sub-2" {
  vpc_id            = aws_vpc.three-tier-vpc.id
  cidr_block        = "192.168.0.64/26" # Public Subnet 2: 192.168.0.64/26 (64 IPs, 64-127).
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "three-tier-pub-sub-2"
  }
}


# Private Subnets
resource "aws_subnet" "three-tier-pvt-sub-1" {
  vpc_id                  = aws_vpc.three-tier-vpc.id
  cidr_block              = "192.168.0.128/27" # Private Subnet 1: 192.168.0.128/27 (32 IPs, 128-159).
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "three-tier-pvt-sub-1"
  }
}
resource "aws_subnet" "three-tier-pvt-sub-2" {
  vpc_id                  = aws_vpc.three-tier-vpc.id
  cidr_block              = "192.168.0.160/27" # Private Subnet 2: 192.168.0.160/27 (32 IPs, 160-191).
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "three-tier-pvt-sub-2"
  }
}

resource "aws_subnet" "three-tier-pvt-sub-3" {
  vpc_id                  = aws_vpc.three-tier-vpc.id
  cidr_block              = "192.168.0.192/27" # Private Subnet 3: 192.168.0.192/27 (32 IPs, 192-223)
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "three-tier-pvt-sub-3"
  }
}
resource "aws_subnet" "three-tier-pvt-sub-4" {
  vpc_id                  = aws_vpc.three-tier-vpc.id
  cidr_block              = "192.168.0.224/27" # Private Subnet 4: 192.168.0.224/27 (32 IPs, 224-255).
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "three-tier-pvt-sub-4"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "three-tier-igw" {
  tags = {
    Name = "three-tier-igw"
  }
  vpc_id = aws_vpc.three-tier-vpc.id
}

# Create a Route Table
resource "aws_route_table" "three-tier-web-rt" {
  vpc_id = aws_vpc.three-tier-vpc.id
  tags = {
    Name = "three-tier-web-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.three-tier-igw.id
  }
}

resource "aws_route_table" "three-tier-app-rt" {
  vpc_id = aws_vpc.three-tier-vpc.id
  tags = {
    Name = "three-tier-app-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.three-tier-natgw-01.id
  }
}


# Route Table Association
resource "aws_route_table_association" "three-tier-rt-as-1" {
  subnet_id      = aws_subnet.three-tier-pub-sub-1.id
  route_table_id = aws_route_table.three-tier-web-rt.id
}

resource "aws_route_table_association" "three-tier-rt-as-2" {
  subnet_id      = aws_subnet.three-tier-pub-sub-2.id
  route_table_id = aws_route_table.three-tier-web-rt.id
}

resource "aws_route_table_association" "three-tier-rt-as-3" {
  subnet_id      = aws_subnet.three-tier-pvt-sub-1.id
  route_table_id = aws_route_table.three-tier-app-rt.id
}
resource "aws_route_table_association" "three-tier-rt-as-4" {
  subnet_id      = aws_subnet.three-tier-pvt-sub-2.id
  route_table_id = aws_route_table.three-tier-app-rt.id
}

resource "aws_route_table_association" "three-tier-rt-as-5" {
  subnet_id      = aws_subnet.three-tier-pvt-sub-3.id
  route_table_id = aws_route_table.three-tier-app-rt.id
}
resource "aws_route_table_association" "three-tier-rt-as-6" {
  subnet_id      = aws_subnet.three-tier-pvt-sub-4.id
  route_table_id = aws_route_table.three-tier-app-rt.id
}

# Create an Elastic IP address for the NAT Gateway
resource "aws_eip" "three-tier-nat-eip" {
  vpc = true
}

#NatGW
resource "aws_nat_gateway" "three-tier-natgw-01" {
  allocation_id = aws_eip.three-tier-nat-eip.id
  subnet_id     = aws_subnet.three-tier-pub-sub-1.id

  tags = {
    Name = "three-tier-natgw-01"
  }
  depends_on = [aws_internet_gateway.three-tier-igw]
}

# Create Load balancer - web tier
resource "aws_lb" "three-tier-web-lb" {
  name               = "three-tier-web-lb"
  internal           = false
  load_balancer_type = "application"
  
  security_groups    = [aws_security_group.three-tier-alb-sg-1.id]
  subnets            = [aws_subnet.three-tier-pub-sub-1.id, aws_subnet.three-tier-pub-sub-2.id]

  tags = {
    Environment = "three-tier-web-lb"
  }
}

# create load balancer - app tier

resource "aws_lb" "three-tier-app-lb" {
  name               = "three-tier-app-lb"
  internal           = true
  load_balancer_type = "application"
  
  security_groups    = [aws_security_group.three-tier-alb-sg-2.id]
  subnets            = [aws_subnet.three-tier-pvt-sub-1.id, aws_subnet.three-tier-pvt-sub-2.id]

  tags = {
    Environment = "three-tier-app-lb"
  }
}

# create load balancer larget group - web tier

resource "aws_lb_target_group" "three-tier-web-lb-tg" {
  name     = "three-tier-web-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.three-tier-vpc.id

  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# create load balancer larget group - app tier

resource "aws_lb_target_group" "three-tier-app-lb-tg" {
  name     = "three-tier-app-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.three-tier-vpc.id

  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# Create Load Balancer listener - web tier
resource "aws_lb_listener" "three-tier-web-lb-listner" {
  load_balancer_arn = aws_lb.three-tier-web-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.three-tier-web-lb-tg.arn
  }
}

## Create Load Balancer listener - app tier
resource "aws_lb_listener" "three-tier-app-lb-listner" {
  load_balancer_arn = aws_lb.three-tier-app-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.three-tier-app-lb-tg.arn
  }
}

# Register the instances with the target group - web tier
resource "aws_autoscaling_attachment" "three-tier-web-asattach" {
  autoscaling_group_name = aws_autoscaling_group.three-tier-web-asg.name
  lb_target_group_arn   = aws_lb_target_group.three-tier-web-lb-tg.arn
  
}

# Register the instances with the target group - app tier
resource "aws_autoscaling_attachment" "three-tier-app-asattach" {
  autoscaling_group_name = aws_autoscaling_group.three-tier-app-asg.name
  lb_target_group_arn   = aws_lb_target_group.three-tier-app-lb-tg.arn
}