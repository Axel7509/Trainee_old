provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"

  aws_region = var.aws_region
}

module "bastion" {
  source = "./modules/bastion"

  ssh_key_name  = var.ssh_key_name
  public_subnet = module.vpc.public_subnet
  bastion_sg_id = module.vpc.bastion_sg_id
}

module "private_server" {
  source = "./modules/private"

  ssh_key_name   = var.ssh_key_name
  private_subnet = module.vpc.private_subnet
  private_sg_id  = module.vpc.private_sg_id
}
