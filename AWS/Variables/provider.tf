terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.42.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  profile = "innovork"
  region  = "us-east-1"
}