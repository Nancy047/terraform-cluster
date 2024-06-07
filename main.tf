
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}


provider "google" {
  credentials = "keys.json"
  project     = "my-project"
}

resource "google_container_cluster" "default" {
  name     = "my-cluster"
  location = "us-central1-c"
  initial_node_count = 3

  node_config {
    machine_type = "n1-standard-1"
  }
}
