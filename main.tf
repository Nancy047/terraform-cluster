
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
 project  = "lumen-b-ctl-047"

  remove_default_node_pool = true
  initial_node_count       = 1

  networking_mode = "k8s_pod_networking"

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/14"
    services_ipv4_cidr_block = "/20"
  }
}

resource "google_container_node_pool" "pool_1" {
  name       = "pool-1"
  location  = "us-central1"
  project   = "lumen-b-ctl-047"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    enabled = false
  }
}

resource "google_container_node_pool" "pool_2" {
  name       = "pool-2"
  location  = "us-central1"
  project   = "lumen-b-ctl-047"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    enabled = false
  }
}
