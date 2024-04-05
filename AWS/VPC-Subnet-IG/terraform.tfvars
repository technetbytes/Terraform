## Project Variables
region      = "ap-southeast-1"
project     = "edifice"
environment = "dev"
domain_name = "infrafy.codetronix.xyz" #Format => <project>.<company-name>.<domain-extensions>
profile     = "innovork"               # 



## VPC variables
vpc-cidr-block              = "10.20.0.0/16"
public-subnets-cidr-blocks  = ["10.20.0.0/24", "10.20.1.0/24", "10.20.2.0/24"]
private-subnets-cidr-blocks = ["10.20.3.0/24", "10.20.4.0/24", "10.20.5.0/24"]

public-subnet-1-cidr-block = "10.20.0.0/24"
public-subnet-2-cidr-block = "10.20.1.0/24"
public-subnet-3-cidr-block = "10.20.2.0/24"

private-subnet-1-cidr-block = "10.20.3.0/24"
private-subnet-2-cidr-block = "10.20.4.0/24"
private-subnet-3-cidr-block = "10.20.5.0/24"