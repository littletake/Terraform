resource "aws_security_group" "allow_ssh_8080_24220"{
  name = "allow_ssh_8080_24220"
  ingress{
  from_port  = 22
  to_port    = 22
  protocol   = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
  from_port  = 8080
  to_port    = 8080
  protocol   = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
  from_port  = 24220
  to_port    = 24220
  protocol   = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
  from_port  = 24220
  to_port    = 24220
  protocol   = "udp"
  cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
  from_port  = 0
  to_port    = 0
  protocol   = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
  description = "allow tcp 22 and 8080"
}
