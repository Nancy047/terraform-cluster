
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
  project  = "lumen-b-ctl-047"

  networking_mode = "SYSTEM_DEFAULT"

  remove_default_node_pool = true

  initial_node_count = 1
}

resource "google_container_node_pool" "nodes_pool_0" {
  name       = "pool-0"
  location  = "us-central1"
  project   = "lumen-b-ctl-047"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    enabled = false
  }
}

resource "google_container_node_pool" "nodes_pool_1" {
  name       = "pool-1"
  location  = "us-central1"
  project   = "lumen-b-ctl-047"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    enabled = false
  }
}
