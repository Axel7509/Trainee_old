output "bastion_public_ip" {
  description = "Public Ip bastion host"
  value       = aws_instance.Bastion.public_ip
}

output "private_server_ip" {
  description = "Private ip host"
  value       = aws_instance.Private.public_ip
}
