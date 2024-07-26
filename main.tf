
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

resource "google_compute_instance" "default" {
  name         = "[vm_name]"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  network_interface {
    network = "default"
  }
}

resource "google_apigee_instance" "default" {
  name     = "[apigee_instance_name]"
  location = "us-central1"
  environment {
    name = "test"
  }
  size = "evaluation"
}

resource "google_container_cluster" "default" {
  name     = "[kubernetes_cluster_name]"
  location = "us-central1-a"
  initial_node_count = 1
  node_config {
    machine_type = "e2-medium"
  }
  master_auth {
    username = "admin"
  }
}

resource "google_storage_bucket" "default" {
  name     = "[storage_bucket_name]"
  location = "US"
  force_destroy = true
}

resource "google_batch_job" "default" {
  name     = "[batch_job_name]"
  location = "us-central1"
  job {
    task {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      command = ["echo", "Hello, world!"]
    }
  }
}

resource "google_sql_database" "default" {
  name     = "[sql_database_name]"
  instance = "[sql_instance_name]"
}
