
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
  name     = "[cluster_name]"
  location = "us-central1"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-2"
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
  }
  enable_kubernetes_alpha = true
  min_master_version = "1.19.10-gke.1000"
  max_master_version = "1.20.x"
  remove_default_node_pool = true
  node_pools {
    name = "default-pool"
    initial_node_count = 3
    node_config {
      machine_type = "n1-standard-2"
    }
    autoscaling {
      min_nodes = 2
      max_nodes = 5
    }
  }
}

resource "google_cloudfunctions_function" "default" {
  name     = "[function_name]"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = "[bucket_name]"
  source_archive_object = "[object_name]"
  trigger_http = true
  region = "us-central1"
  memory = 256
  timeout = 60
}

resource "google_error_reporting_service" "default" {
  name     = "[service_name]"
  project = "abc"
  service_context {
    service = "[service_name]"
    version = "1.0.0"
  }
}

resource "google_cloud_run_v2_service" "default" {
  name     = "[service_name]"
  location = "us-central1"
  template {
    containers {
      image = "[container_image]"
      resources {
        limits {
          cpu = "1"
          memory = "256Mi"
        }
      }
    }
  }
  metadata {
    annotations = {
      "run.googleapis.com/ingress" = "all"
    }
  }
}
