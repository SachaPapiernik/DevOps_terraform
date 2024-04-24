provider "google" {
  credentials = file("terraform-421308-4d7d9e5c0fc3.json")
  project     = "terraform-421308"
  region      = "europe-west1"
}

resource "google_compute_address" "static_ip" {
  name   = "my-static-ip"
  region = "europe-west1"
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"

}

resource "google_compute_instance" "vm_instance" {
  name         = "my-instance2"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
    
    boot_disk {
        auto_delete = true

        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        network = "default"
        access_config {
            nat_ip = google_compute_address.static_ip.address
        }
    }

    metadata = {
        sshKeys = "debian:${tls_private_key.ssh.public_key_openssh}"
    }
}

resource "google_compute_firewall" "demo-ssh-ipv4" {
    name    = "staging-demo-ssh-ipv4"
    network = "default"

    allow {
        protocol = "tcp"
        ports    = [22]
    }

    allow {
        protocol = "udp"
        ports    = [22]
    }

    allow {
        protocol = "sctp"
        ports    = [22]
    }

    source_ranges = ["0.0.0.0/0"]
}

resource "local_file" "local_ssh_key" {
    content  = tls_private_key.ssh.private_key_pem
    filename = "${path.root}/ssh-keys/ssh_key"
}

resource "local_file" "local_ssh_key_pub" {
    content  = tls_private_key.ssh.public_key_openssh
    filename = "${path.root}/ssh-keys/ssh_key.pub"
}