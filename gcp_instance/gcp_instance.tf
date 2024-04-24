provider "google" {
  credentials = file("terraform-421308-4d7d9e5c0fc3.json")
  project = "terraform-421308"
  region  = "europe-west1"
}

resource "google_compute_address" "static_ip" {
  name   = "my-static-ip"
  region = "europe-west1"
}

resource "google_compute_instance" "vm_instance" {
  name         = "my-instance"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"

  boot_disk {
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
}
