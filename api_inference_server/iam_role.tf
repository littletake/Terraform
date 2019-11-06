// ec2とs3のリソースに対するiamロール
resource "aws_iam_role_policy" "ec2_s3_access_policy" {
    name = "ec2_s3_access_policy"
    role = "${aws_iam_role.ec2_s3_access_role.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "ec2_s3_access_role" {
    name = "ec2_s3_access_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "api_inference_server_profile" {
  name = "api_inference_server_profile"
  roles = ["${aws_iam_role.ec2_s3_access_role.name}"]
}
