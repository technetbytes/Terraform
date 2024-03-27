provider "aws" {
  profile = "innovork"
  region  = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
}

