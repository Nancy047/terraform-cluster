
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
  project     = "cvgbhjnkm"
}

resource "google_container_cluster" "default" {
  name     = "cfvgbh"
  location = "us-central1-c"
  initial_node_count = 2
  node_config {
    machine_type = "e2-medium"
  }
}
