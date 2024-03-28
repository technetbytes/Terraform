variable "ami" {
  type        = string
  default     = "ami-0c101f26f147fa7fd"
  description = "Ubuntu AMI ID"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type"
}

variable "ec2_tag" {
  type        = string
  default     = "EC2-Terraform"
  description = "Name of the EC2 Instance"
}