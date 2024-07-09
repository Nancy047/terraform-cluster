
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
  initial_node_count = 1
  node_config {
    machine_type = "e2-medium"
  }
  min_master_version = "1.19.10-gke.1000"
  master_auth {
    username = "admin"
  }
  network = "default"
  subnetwork = "projects/abc/regions/us-central1/subnetworks/default"
}

resource "google_cloudfunctions_function" "default" {
  name     = "[function_name]"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = "[bucket_name]"
  source_archive_object = "[object_name]"
  trigger_http = true
  region = "us-central1"
}

resource "google_app_engine_application" "default" {
  location_id = "us-central1"
  project = "abc"
}

resource "google_app_engine_service" "default" {
  name     = "[service_name]"
  location = "us-central1"
  application = google_app_engine_application.default.name
  runtime = "nodejs16"
  entry_point = "app.js"
  env = "standard"
  scaling {
    max_instances = 1
  }
}
