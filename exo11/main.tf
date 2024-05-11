provider "null" {}

resource "null_resource" "install_figlet" {
  connection {
    type        = "ssh"
    host        = "34.78.42.172"
    user        = "sacha_papiernik"
    private_key = file("../gcp_instance/ssh-keys/ssh_key")
    check_host_key = true
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y figlet",
    ]
  }
}
