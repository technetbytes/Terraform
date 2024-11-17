output "vpc_id" {
  value = resource.aws_vpc.technet-vpc.id
}

output "vpc_cidr_block" {
  value = resource.aws_vpc.technet-vpc.cidr_block
}