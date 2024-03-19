variable "ssh_key_name" {}
variable "private_subnet" {}
variable "private_sg_id" {}

data "aws_ami" "example" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}


resource "aws_instance" "Private" {
  ami                    = data.aws_ami.example.id
  instance_type          = "t3.micro"
  subnet_id              = var.private_subnet
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [var.private_sg_id]
  tags = {
    "Name" = "Privat"
  }
}
