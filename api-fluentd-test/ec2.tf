provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "api_server" {
  ami                    = "ami-09b68f5653871885f" # ubuntu18.04
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = [
    "${aws_security_group.allow_ssh_8080_24220.id}"
  ]
  tags                   = {
    Name = "haga"
    Memo = "api_server"
  }
}

resource "aws_instance" "fluentd_server" {
  ami                    = "ami-09b68f5653871885f" # ubuntu18.04
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = [
    "${aws_security_group.allow_ssh_8080_24220.id}"
  ]
  tags                   = {
    Name = "haga"
    memo = "fluentd_server"
  }
}

resource "aws_key_pair" "auth" {
  key_name = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}
