terraform {
    # configure required provider
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version =  "~> 5.42.0" #"~>4"
    }
  }
}

# provider detail with region setting
provider "aws" {
    profile = "default"
    region = "us-east-1"
}