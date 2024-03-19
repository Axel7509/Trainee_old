provider "aws" {
  region = "us-east-1"
}

data "aws_billing_service_account" "main" {}
data "aws_region" "current" {}
data "aws_availability_zones" "current" {}

output "data_aws_billing" {
  value = data.aws_billing_service_account.main
}

output "data_aws_region" {
  value = data.aws_region.current.name
}

output "data_aws_zones" {
  value = data.aws_availability_zones.current.names
}

data "aws_ami" "example" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

output "ub_ami_id" {
  value = data.aws_ami.example.id
}

output "ub_ami_name" {
  value = data.aws_ami.example.name
}
