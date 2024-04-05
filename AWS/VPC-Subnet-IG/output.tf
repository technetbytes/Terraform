output "vpc_id" {
  value = resource.aws_vpc.kodetronix-vpc.id
}

output "vpc_cidr_block" {
  value = resource.aws_vpc.kodetronix-vpc.cidr_block
}