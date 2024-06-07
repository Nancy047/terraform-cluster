
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
  project     = "my-project"
}

resource "google_container_cluster" "default" {
  name     = "demo-clus"
  location = "us-central1-c"
  initial_node_count = 2
  node_config {
    machine_type = "n1-standard-1"
  }
}
