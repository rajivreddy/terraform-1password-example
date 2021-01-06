provider "onepassword" {
    email      = "rajeev.jaggavarapu@srijan.net"
    password   = "23wesdxc@#WESDXC$$##%%"
    secret_key = "A3-ZJ4GK5-3QDRWG-DDX8R-QRBC3-V4YFD-NNH29"
    subdomain  = "oncorps"
}
provider "aws" {
  region = "us-west-2"
}

resource "null_resource" "install_op" {
provisioner "local-exec" {
    command = "echo ${aws_instance.web.private_ip} >> private_ips.txt"
  }
}