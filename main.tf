
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

resource "google_container_cluster" "primary" {
  name     = "my-cluster"
  location = "us-central1"
 project  = "lumen"

  remove_default_node_pool = true
  initial_node_count       = 1

  autoscaling {
    enabled = true
  }
}

resource "google_container_node_pool" "pool_1" {
  name       = "pool-1"
  location  = "us-central1"
  project   = "lumen"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    enabled = true
    min_nodes = 1
    max_nodes = 3
  }
}

resource "google_container_node_pool" "pool_2" {
  name       = "pool-2"
  location  = "us-central1"
  project   = "lumen"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    enabled = true
    min_nodes = 1
    max_nodes = 3
  }
}
