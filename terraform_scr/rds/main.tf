provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "amogus" {
  identifier          = var.identifier
  instance_class      = var.instance_class
  allocated_storage   = var.allocated_storage
  engine              = var.engine
  engine_version      = var.engine_version
  username            = var.username
  password            = var.password
  publicly_accessible = true
  skip_final_snapshot = true
}
