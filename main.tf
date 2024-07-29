
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
    machine_type = "n1-standard-4"
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
  enable_autoscaling = true
  min_master_nodes = 3
  max_master_nodes = 5
  min_nodes = 3
  max_nodes = 5
}

resource "google_cloudfunctions_function" "default" {
  name     = "gcp-cloud-function"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = "gcp-cloud-function-bucket"
  source_archive_object = "gcp-cloud-function.zip"
  trigger_http = true
  memory = 256
  timeout = 60
  region = "us-central1"
  ingress_settings = "ALLOW_ALL"
  available_memory = 256
  max_instance_count = 100
  min_instance_count = 1
}

resource "google_app_engine_application" "default" {
  location_id = "us-central1"
  name        = "gcp-app-engine-app"
}

resource "google_app_engine_service" "default" {
  name     = "gcp-app-engine-service"
  location = "us-central1"
  application = google_app_engine_application.default.name
  env = "flexible"
  runtime = "nodejs16"
  scaling {
    max_instances = 100
    min_instances = 1
  }
  resources {
    cpu = 1
    memory_gb = 1
    disk_size_gb = 10
  }
}
