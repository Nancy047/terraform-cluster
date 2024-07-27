
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
    disk_size_gb = 100
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
    ]
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
  enable_kubernetes_alpha {
    enable_pod_security_policy = true
  }
  logging_service {
    logging_component = "GKE_AUDIT_LOGGING"
  }
  monitoring_service {
    monitoring_component = "GKE_AUDIT_LOGGING"
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
  available_memory = 256
  max_instance_count = 100
  min_instance_count = 1
  ingress_settings = "ALLOW_ALL"
  service_config {
    all_traffic_on_latest_revision = true
  }
}

resource "google_app_engine_application" "default" {
  name     = "[app_name]"
  location = "us-central1"
  project  = "abc"
}

resource "google_app_engine_service" "default" {
  name     = "[service_name]"
  application = google_app_engine_application.default.name
  location = "us-central1"
  project  = "abc"
  env = "standard"
  runtime = "nodejs16"
  scaling {
    max_instances = 100
    min_instances = 1
    manual_scaling {
      instances = 1
    }
  }
  ingress_settings = "ALLOW_ALL"
  basic_scaling {
    max_instances = 100
    min_instances = 1
  }
}
