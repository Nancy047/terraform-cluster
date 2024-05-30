
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  credentials = "key.json"
  project     = "us-central1"
}

resource "google_container_cluster" "default" {
  name     = "my-cluster"
  location = "us-central1-c"
  initial_node_count = 2
  node_config {
    machine_type = "n1-standard-1"
  }
}
