variable "package_name" {
  description = "The name of the package to install with Chocolatey"
  default     = "figlet"
}

provider "null" {
}

resource "null_resource" "install_package" {
  triggers = {
    reinstall_key = timestamp()
  }

  provisioner "local-exec" {
    command = "powershell Start-Process powershell -Verb runAs -ArgumentList 'choco install ${var.package_name} -y'"
  }
}

