#----commit----

provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "test" {
  ami           = "ami-0cd59ecaf368e5ccf"
  instance_type = "t2.micro"
  tags = {
    "Name" = "test"
  }

  vpc_security_group_ids = [aws_security_group.my_web.id]
}

resource "aws_security_group" "my_web" {
  name        = "my_web"
  description = "my_web"

  tags = {
    Name = "my_web"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_80_ipv4" {
  security_group_id = aws_security_group.my_web.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.my_web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
