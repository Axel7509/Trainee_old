
output "web_server_inst_id" {
  value = aws_instance.test.id
}

output "web_server_pub_ip_addr" {
  value = aws_instance.test.public_ip
}

output "web_server_sg_id" {
  value = aws_security_group.my_web.id
}

output "web_server_sg_arn" {
  value = aws_security_group.my_web.arn
}
