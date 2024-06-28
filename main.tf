
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
  name     = "default-cluster"
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

resource "google_compute_target_http_proxy" "default" {
  name = "default-http-proxy"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  name = "default-url-map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_backend_service" "default" {
  name = "default-backend-service"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_health_check" "default" {
  name = "default-health-check"
  check_interval_sec = 5
  timeout_sec = 5
  healthy_threshold = 2
  unhealthy_threshold = 2
  http_health_check {
    port = 80
    request_path = "/"
  }
}

resource "google_monitoring_alert_policy" "default" {
  display_name = "default-alert-policy"
  combiner = "OR"
  conditions {
    condition_threshold {
      filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND metric.labels.instance_name=\"default-instance\""
      duration = "60s"
      trigger {
        count = 2
        period = "60s"
      }
      comparison = "GREATER_THAN_OR_EQUAL"
      threshold_value = 0.8
    }
  }
  notification_channels = [google_monitoring_notification_channel.default.name]
}

resource "google_monitoring_notification_channel" "default" {
  display_name = "default-notification-channel"
  type = "email"
  labels = {
    email_address = "example@example.com"
  }
}

resource "google_storage_bucket" "default" {
  name = "default-bucket"
  location = "US"
  force_destroy = true
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_sql_database" "default" {
  name     = "default-database"
  instance = google_sql_database_instance.default.name
}

resource "google_sql_database_instance" "default" {
  name = "default-instance"
  region = "us-central1"
  database_version = "MYSQL_5_7"
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_cloudfunctions_function" "default" {
  name = "default-function"
  runtime = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = google_storage_bucket.default.name
  source_archive_object = "function.zip"
  trigger_http = true
  timeout_seconds = 60
  memory = "128M"
  available_memory = "128M"
  ingress_settings = "ALLOW_ALL"
  region = "us-central1"
}

resource "google_cloud_run_v2_service" "default" {
  name     = "default-service"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "100m"
          memory = "128Mi"
        }
      }
    }
  }
}
