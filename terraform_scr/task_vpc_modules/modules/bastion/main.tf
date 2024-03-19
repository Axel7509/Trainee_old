
variable "ssh_key_name" {}
variable "public_subnet" {}
variable "bastion_sg_id" {}

data "aws_ami" "example" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "Bastion" {
  ami                    = data.aws_ami.example.id
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [var.bastion_sg_id]
  tags = {
    "Name" = "Bastion"
  }
}
