
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  credentials = file("key.json")
  project     = "lumen-b-ctl-047"
}

resource "google_compute_instance" "default" {
  name         = "demo-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
 network_interface {}
}
