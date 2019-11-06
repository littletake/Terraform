provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "sandbox" {
  count         = 2
  ami           = "ami-785c491f" # Ubuntu 16.04 LTS official ami
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  key_name      = "${aws_key_pair.auth.id}"
  tags = { Name = "haga" }
}

resource "aws_key_pair" "auth" {
  key_name = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}
