
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = "lumen-b-ctl-047"
}

resource "google_container_cluster" "primary" {
  name     = "gke-cluster-name"
  location = "us-central1"

  initial_node_pool {
    name               = "default-pool"
    autoscaling        = true
    min_node_count     = 1
    max_node_count     = 3
    node_locations = ["us-central1-a", "us-central1-b", "us-central1-c"]
  }

  remove_default_node_pool = true
}
