terraform {
  required_providers {
    onepassword = {
      source = "anasinnyk/onepassword"
      version = "1.2.1"
    }
  }
}


provider "onepassword" {
}


provider "aws" {
  region = "us-west-2"
}
resource "null_resource" "install_op" {

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "whoami; ls -al; wget https://cache.agilebits.com/dist/1P/op/pkg/v1.8.0/op_linux_amd64_v1.8.0.zip; unzip op_linux_amd64_v1.8.0.zip;echo $PATH;export PATH=$PWD:$PATH;echo $PATH; op --version"
  }
}

resource "aws_iam_user" "lb" {
  name = "terraform-test-user"
  path = "/"
  depends_on = [ 
    null_resource.install_op
   ]
}

resource "aws_iam_access_key" "lb" {
  user = aws_iam_user.lb.name
}
resource "onepassword_item_login" "this" {
  name     = "terraform-test-user"
  username = aws_iam_access_key.lb.id
  password = aws_iam_access_key.lb.secret
  url      = "https://console.aws.amazon.com/console/home"
  vault    = "Infrastructure"
  notes = "This is created via Terraform"
  tags = ["terraform","test-user","1password"]
}
