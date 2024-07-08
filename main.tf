
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
  initial_node_count = 1
  node_config {
    machine_type = "e2-medium"
  }
  min_master_version = "1.19.10-gke.1000"
  master_auth {
    username = "admin"
  }
  network = "default"
  subnetwork = "projects/gcp-project-id/regions/us-central1/subnetworks/default"
}

resource "google_cloudfunctions_function" "default" {
  name     = "gcp-cloud-function"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = "gcp-cloud-function-bucket"
  source_archive_object = "gcp-cloud-function.zip"
  trigger_http = true
  region = "us-central1"
}

resource "google_data_lineage_domain" "default" {
  name     = "gcp-data-lineage-domain"
  location = "us-central1"
}
