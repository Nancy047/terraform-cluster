
provider "google" {
  credentials = file("credentials.json")
  project     = "lumen-b-ctl-047"
}

resource "google_compute_instance" "default" {
  name         = "demo1-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

 boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {}
}
