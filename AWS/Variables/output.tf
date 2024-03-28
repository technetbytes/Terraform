output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "Public IP Address of EC2 instance"
}

output "instance_id" {
  value       = aws_instance.example.id
  description = "Instance ID"
}