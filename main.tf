
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
  project     = "vbnm"
}

resource "google_container_cluster" "default" {
  name     = "cvbn"
  location = "us-central1-c"

  initial_node_count = 1
  node_config {
    machine_type = "n1-standard-1"
  }

  master_auth {
    username = "admin"
  }
}
