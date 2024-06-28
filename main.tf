
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
  project     = "abc"
}

resource "google_container_cluster" "default" {
  name     = "gcp-kubernetes-cluster"
  location = "us-central1"
  initial_node_count = 3
  node_config {
    machine_type = "e2-medium"
  }
  master_auth {
    username = "admin"
  }
  network = "default"
  subnetwork = "projects/gcp-project-id/regions/us-central1/subnetworks/default"
  ip_allocation_policy {
    use_ip_aliases = true
  }
  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }
  logging_service {
    enabled = true
  }
  monitoring_service {
    enabled = true
  }
  network_policy {
    enabled = true
  }
  maintenance_policy {
    window {
      day = "MONDAY"
      start_time = "03:00"
      duration = "3600s"
    }
  }
  min_master_version = "1.19.10-gke.1000"
  max_master_version = "1.20.10-gke.1000"
  remove_default_node_pool = true
  node_pools {
    name = "default-pool"
    initial_node_count = 3
    node_config {
      machine_type = "e2-medium"
    }
    autoscaling {
      min_nodes = 2
      max_nodes = 5
    }
  }
}
