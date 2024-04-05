terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.42.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region  = "ap-southeast-1"
  profile = "innovork"
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