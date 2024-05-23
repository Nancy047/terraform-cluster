
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

  remove_default_node_pool   = true
  initial_node_count         = 1
  enable_legacy_abac         = false
  vertical_pod_autoscaling = true
}

resource "google_container_node_pool" "pools" {
  name       = "pool-01"
  location  = "us-central1"
  project   = "lumen-b-ctl-047"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    enabled = false
  }
}

resource "google_container_node_pool" "pools-02" {
  name       = "pool-02"
  location  = "us-central1"
  project   = "lumen-b-ctl-047"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    enabled = false
  }
}
