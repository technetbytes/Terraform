# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Create an EC2 instance
resource "aws_instance" "ec2test2" {
  ami           = "ami-012967cc5a8c9f891"
  instance_type = "t2.micro"
}
