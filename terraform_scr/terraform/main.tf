provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_Ubuntu" {
  ami           = "ami-0cd59ecaf368e5ccf"
  instance_type = "t3.micro"
  key_name      = "Trainee_key_aws"
  tags = {
    Name        = "test_terraform"
    Environment = "production"
  }
}
