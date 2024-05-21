
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

resource "google_container_cluster" "primary" {
  name     = "demo-cluster"
  location = "us-central1"
  project  = "demo-project"

  remove_default_node_pool = true
  initial_node_pools {
    name             = "default-pool"
    initial_node_count = 1
  }
}

resource "google_container_node_pool" "pool1" {
  name       = "pool-1"
  location  = "us-central1"
  cluster   = google_container_cluster.primary.name
  project    = "demo-project"
  node_count = 1
  autoscaling {
    enabled = false
  }
}

resource "google_container_node_pool" "pool2" {
  name       = "pool-2"
  location  = "us-central1"
  cluster   = google_container_cluster.primary.name
  project    = "demo-project"
  node_count = 1
  autoscaling {
    enabled = false
  }
}
