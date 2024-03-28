resource "aws_instance" "example" {
  ami           = var.ami //Ubuntu AMI
  instance_type = var.instance_type

  tags = {
    Name = var.ec2_tag
  }
}