provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

// user_data: s3からダウンロード
resource "aws_instance" "api_server" {
  ami                    = "ami-09b68f5653871885f" # ubuntu18.04
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.auth.id}"
  user_data = <<EOF
  IyEvYmluL2Jhc2gKIyBmb3IgdXNlcmRhdGEKCmF3cz0iL3Vzci9sb2NhbC9iaW4v
YXdzIC0tcmVnaW9uIGFwLW5vcnRoZWFzdC0xIgp3b3JrX2Rpcj0iL2hvbWUvdWJ1
bnR1L3dvcmtzcGFjZSIKczNfdXJsPSJzMzovL3Rlc3QtdGVycmFmb3JtLXRha2Uv
YXBpX3NlcnZlciIKbG9nZ2VyPSJsb2dnZXIgLXQgJDAiCgojIC0tIGNvbW1hbmQg
LS0KJHtsb2dnZXJ9ICJzdGFydCBzY2lycHQuIgpta2RpciAtcCAiJHt3b3JrX2Rp
cn0iCgojIC0tIGluc3RhbGwgYXdzY2xpIC0tCnN1ZG8gYXB0IHVwZGF0ZSAteQpz
dWRvIGFwdCB1cGdyYWRlIC15CnN1ZG8gYXB0IGluc3RhbGwgcHl0aG9uMy1waXAg
LXkKc3VkbyBwaXAzIGluc3RhbGwgLVUgcGlwCnN1ZG8gcGlwIGluc3RhbGwgYXdz
Y2xpCgojIC0tIGRvd25sb2FkICAtLQoke2F3c30gczMgY3AgLS1yZWN1cnNpdmUg
IiR7czNfdXJsfSIgIiR7d29ya19kaXJ9Igoke2xvZ2dlcn0gImZpbmlzaGVkLiIK
ZXhpdCAwCg==
EOF
  iam_instance_profile = "${aws_iam_instance_profile.api_inference_server_profile.name}"
  tags                   = {Name = "api_server"}
}

resource "aws_instance" "inference_server" {
  ami                    = "ami-09b68f5653871885f" # ubuntu18.04
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.auth.id}"
  user_data = <<EOF
  IyEvYmluL2Jhc2gKIyBmb3IgdXNlcmRhdGEKCmF3cz0iL3Vzci9sb2NhbC9iaW4v
YXdzIC0tcmVnaW9uIGFwLW5vcnRoZWFzdC0xIgp3b3JrX2Rpcj0iL2hvbWUvdWJ1
bnR1L3dvcmtzcGFjZSIKczNfdXJsPSJzMzovL3Rlc3QtdGVycmFmb3JtLXRha2Uv
aW5mZXJlbmNlX3NlcnZlciIKbG9nZ2VyPSJsb2dnZXIgLXQgJDAiCgojIC0tIGNv
bW1hbmQgLS0KJHtsb2dnZXJ9ICJzdGFydCBzY2lycHQuIgpta2RpciAtcCAiJHt3
b3JrX2Rpcn0iCgojIC0tIGluc3RhbGwgYXdzY2xpIC0tCnN1ZG8gYXB0IHVwZGF0
ZSAteQpzdWRvIGFwdCB1cGdyYWRlIC15CnN1ZG8gYXB0IGluc3RhbGwgcHl0aG9u
My1waXAgLXkKc3VkbyBwaXAzIGluc3RhbGwgLVUgcGlwCnN1ZG8gcGlwIGluc3Rh
bGwgYXdzY2xpCgojIC0tIGRvd25sb2FkIC0tCiR7YXdzfSBzMyBjcCAtLXJlY3Vy
c2l2ZSAiJHtzM191cmx9IiAiJHt3b3JrX2Rpcn0iCiR7bG9nZ2VyfSAiZmluaXNo
ZWQuIgpleGl0IDAK
EOF
  iam_instance_profile = "${aws_iam_instance_profile.api_inference_server_profile.name}"
  tags                   = {Name = "inference_server"}
}

resource "aws_key_pair" "auth" {
  key_name = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}
