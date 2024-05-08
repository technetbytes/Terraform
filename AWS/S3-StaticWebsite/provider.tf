terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.42.0"
    }
  }
}

# Configure the AWS Provider according to the aws console profile
provider "aws" {
  profile = "acm"
  region  = "us-east-1"
}

# Configuring S3 and DynamoDB backend for Terraform state
# terraform init -reconfigure
terraform {
  backend "s3" {
    bucket         = "testinnovork"
    key            = "terraform.tfstate"
    region         = "ap-southeast-1"
    profile        = "innovork"
    ##dynamodb_table = "infrafy-tfstate-lock-dev"
  }
}