
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  credentials = file("path/to/credentials.json")
  project     = "demo-project"
}

resource "google_container_cluster" "cluster" {
  name     = "cluster"
  location = "us-central1-c"
  initial_node_count = 2
  node_config {
    machine_type = "e2-medium"
  }
}
