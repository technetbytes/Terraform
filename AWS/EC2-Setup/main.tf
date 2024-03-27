# Configure the AWS provider
provider "aws" {
  region = "eu-west-1"
}

# Create an EC2 instance
resource "aws_instance" "ec2test" {
  ami           = "ami-097c4e1feeea169e5"
  instance_type = "t2.micro"
}
