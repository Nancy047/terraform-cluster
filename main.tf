
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

  networking_mode = "VPC_NATIVE"
  initial_node_count = 1

  ip_allocation_policy {
  }

  remove_default_node_pool = true

  node_pool {
    name       = "default-pool"
    node_count = 1
    config {
      machine_type = "e2-medium"
      disk_size_gb = 100
      oauth_scopes = [
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
      ]
    }
  }

  node_pool {
    name       = "secondary-pool"
    node_count = 1
    config {
      machine_type = "e2-standard-4"
      disk_size_gb = 200
      oauth_scopes = [
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
      ]
    }
  }
}
