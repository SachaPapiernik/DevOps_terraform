provider "null" {
}

resource "null_resource" "install_figlet" {
  provisioner "local-exec" {
    command = "powershell Start-Process powershell -Verb runAs -ArgumentList 'choco uninstall figlet -y'"
  }
}
