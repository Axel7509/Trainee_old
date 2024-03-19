provider "aws" {
  region = "us-east-1"
}

variable "allowed_ips" {
  description = "List of allowed IP addresses and rule names"
  type = map(object({
    ip   = string
    rule = string
  }))
  default = {
    my_ip = {
      ip   = "185.177.125.90"
      rule = "my-rule"
    }
  }
}

resource "aws_security_group" "example" {
  name        = "allow-ssh"
  description = "Allow access to port 22 only from specific IP addresses"

  dynamic "ingress" {
    for_each = var.allowed_ips

    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["${ingress.value.ip}/32"]
      description = ingress.value.rule
    }
  }
}
