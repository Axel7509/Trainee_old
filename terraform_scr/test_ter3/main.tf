
#=======================================================================

provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}

data "aws_ami" "example" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

#=======================================================================

resource "aws_security_group" "test_sec_group" {
  name        = "test_sec_group"
  description = "description for my web"

  tags = {
    Name = "test_sec_group"
  }
  dynamic "ingress" {
    for_each = [443, 8000]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_vpc_security_group_ingress_rule" "my_web_80_ipv4" {
  security_group_id = aws_security_group.test_sec_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.test_sec_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_launch_configuration" "web" {
  name            = "web_config"
  image_id        = data.aws_ami.example.id
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.test_sec_group.id]
  user_data       = file("user_data.sh")
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bar" {
  name                 = "asg-example"
  launch_configuration = aws_launch_configuration.web.name
  min_size             = 1
  max_size             = 2
  min_elb_capacity     = 2
  vpc_zone_identifier = [
    aws_default_subnet.default_az1.id,
    aws_default_subnet.default_az2.id
  ]
  health_check_type = "ELB"
  load_balancers    = [aws_elb.bar.name]

  tag {
    key                 = "foo"
    value               = "bar"
    propagate_at_launch = true
  }


  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_elb" "bar" {
  name = "terraform-elb"
  availability_zones = [
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1]
  ]

  security_groups = [aws_security_group.test_sec_group.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }

  tags = {
    Name = "terraform-elb"
  }
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Default subnet for zone_1"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "Default subnet for zone_2"
  }
}


#=======================================================================

output "dns_name_elb" {
  value = aws_elb.bar.dns_name
}
