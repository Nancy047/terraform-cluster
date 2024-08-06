
# Configure the Google Cloud Provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  credentials = file("keys.json")
  project     = "abc"
}

# Deep Learning VM Image
resource "google_compute_instance" "deep_learning_vm" {
  name         = "deep-learning-vm"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  network_interface {
    network = "default"
  }
  metadata = {
    "startup-script" = <<EOF
#!/bin/bash
# Install necessary packages for deep learning
yum update -y
yum install -y python3 python3-pip
pip3 install tensorflow keras
# Your deep learning code goes here
EOF
  }
}
