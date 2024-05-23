
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

resource "google_container_cluster" "primary" {
  name     = "my-cluster"
  location = "us-central1"
 project  = "lumen-b-ctl-047"

  remove_default_node_pool = true
  initial_node_count       = 1

  networking {
    network = "projects/lumen-b-ctl-047/global/networks/default"
  }
}

resource "google_container_node_pool" "nodes" {
  name       = "pool-01"
  location  = "us-central1"
  project   = "lumen-b-ctl-047"
  cluster   = google_container_cluster.primary.name

  node_count = 1

  autoscaling {
    enabled = false
  }
}

resource "google_container_node_pool" "nodes-2" {
  name       = "pool-02"
  location  = "us-central1"
  project   = "lumen-b-ctl-047"
  cluster   = google_container_cluster.primary.name

  node_count = 1

  autoscaling {
    enabled = false
  }
}
