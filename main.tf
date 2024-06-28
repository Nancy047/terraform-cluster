
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
  name     = "gke-cluster"
  location = "us-central1"
  initial_node_count = 3
  node_config {
    machine_type = "e2-medium"
  }
  master_auth {
    username = "admin"
  }
  network = "default"
  subnetwork = "projects/abc/regions/us-central1/subnetworks/default"
}

resource "google_compute_target_http_proxy" "default" {
  name    = "http-proxy"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  name    = "url-map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_backend_service" "default" {
  name = "backend-service"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_health_check" "default" {
  name        = "health-check"
  check_interval_sec = 5
  timeout_sec        = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
  http_health_check {
    port_name = "http"
    port_specification = "USE_NAMED_PORT"
    request_path = "/"
  }
}

resource "google_monitoring_alert_policy" "default" {
  display_name = "Alert Policy"
  combiner     = "OR"
  conditions {
    display_name = "Condition"
    condition_threshold {
      filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND metric.labels.instance_name=\"[vm_name]\" AND resource.type=\"gce_instance\""
      duration = "600s"
      trigger {
        count = 1
        period = "600s"
      }
    }
  }
  notification_channels = [google_monitoring_notification_channel.default.name]
}

resource "google_monitoring_notification_channel" "default" {
  display_name = "Notification Channel"
  type         = "email"
  labels = {
    email_address = "[email_address]"
  }
}

resource "google_storage_bucket" "default" {
  name     = "storage-bucket"
  location = "US"
  force_destroy = true
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_service_account" "default" {
  account_id   = "service-account"
  display_name = "Service Account"
  disabled     = false
}

resource "google_artifact_registry_repository" "default" {
  location = "us-central1"
  project  = "abc"
  repository_id = "repository"
  format = "DOCKER"
}

resource "google_cloudfunctions_function" "default" {
  name     = "cloud-function"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = google_storage_bucket.default.name
  source_archive_object = "function.zip"
  trigger_http = true
  region = "us-central1"
}
