output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet" {
  value = aws_subnet.private_subnet.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "private_sg_id" {
  value = aws_security_group.private_sg.id
}
