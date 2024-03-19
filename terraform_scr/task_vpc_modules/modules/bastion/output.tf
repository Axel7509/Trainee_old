output "bastion_public_ip" {
  value = aws_instance.Bastion.public_ip
}
