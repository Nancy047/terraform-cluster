
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
  location = "us-central1-a"
  project  = "lumen-b-ctl-047"

  remove_default_node_pool = true
  initial_node_count       = 1

  networking_mode = "VPC_NATIVE"

  workload_identity_config {
    workload_pool = "lumen-b-ctl-047.svc.id.goog"
  }
}

resource "google_container_node_pool" "pool1" {
  name       = "pool-1"
  location  = "us-central1-a"
  project   = "lumen-b-ctl-047"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    enabled = false
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

resource "google_container_node_pool" "pool2" {
  name       = "pool-2"
  location  = "us-central1-a"
  project   = "lumen-b-ctl-047"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    enabled = false
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
