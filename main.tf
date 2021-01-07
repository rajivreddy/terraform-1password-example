# provider "onepassword" {
# }


# provider "aws" {
#   region = "us-west-2"
# }
resource "null_resource" "install_op" {

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "whoami; wget https://cache.agilebits.com/dist/1P/op/pkg/v1.8.0/op_linux_amd64_v1.8.0.zip; unzip op_linux_amd64_v1.8.0.zip;echo $PATH;export PATH="$PATH:$PWD";echo $PATH; op --version"
  }
}
