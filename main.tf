# provider "onepassword" {
# }


# provider "aws" {
#   region = "us-west-2"
# }
resource "null_resource" "install_op" {

  provisioner "local-exec" {
    command = "wget https://cache.agilebits.com/dist/1P/op/pkg/v1.8.0/op_linux_amd64_v1.8.0.zip; unzip op_linux_amd64_v1.8.0.zip;mv op /usr/local/bin;echo $PATH;op --version"
  }
}
