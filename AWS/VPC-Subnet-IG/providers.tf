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
  region  = "eu-west-2"
  profile = "aws-access-key-profile"
}

# Configuring S3 and DynamoDB backend for Terraform state
# terraform init -reconfigure
terraform {
  backend "s3" {
    bucket         = "infrafy-backend-tfstate-bucket-dev"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    profile        = "aws-access-key-profile"
    dynamodb_table = "infrafy-tfstate-lock-dev"
  }
}