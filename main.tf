
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

resource "google_storage_bucket" "default" {
  name     = "gs-bucket-basic"
  location = "US"
  force_destroy = true
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
  versioning {
    enabled = false
  }
  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365
    }
  }
}

resource "google_compute_url_map" "default" {
  name    = "cdn-url-map-basic"
  default_service = google_compute_backend_service.default.id
  host_rule {
    hosts = ["*"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name = "allpaths"
    default_service = google_compute_backend_service.default.id
    route_rules {
      header_matches {
        header_name = "Host"
        invert_match = false
        regex_match = true
        values = ["*"]
      }
      match_rules {
        full_path_match = true
        ignore_case = true
        metadata_filters {
          filter_match_criteria = "MATCH_ANY"
          filter_labels {
            name  = "key"
            value = "value"
          }
        }
        query_parameter_matches {
          name  = "key"
          present_match = true
        }
        header_matches {
          header_name = "key"
          invert_match = false
          regex_match = true
          values = ["value"]
        }
        ignore_case = true
        metadata_filters {
          filter_match_criteria = "MATCH_ANY"
          filter_labels {
            name  = "key"
            value = "value"
          }
        }
        query_parameter_matches {
          name  = "key"
          present_match = true
        }
      }
      service = google_compute_backend_service.default.id
    }
  }
}

resource "google_compute_backend_service" "default" {
  name = "cdn-backend-service-basic"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  health_checks = [google_compute_health_check.default.id]
  load_balancing_scheme = "INTERNAL"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  health_checks = [google_compute_health_check.default.id]
  load_balancing_scheme = "INTERNAL"
}

resource "google_compute_health_check" "default" {
  name = "cdn-health-check-basic"
  check_interval_sec = 5
  timeout_sec = 5
  healthy_threshold = 2
  unhealthy_threshold = 2
  http_health_check {
    host = "localhost"
    port = 80
    request_path = "/"
  }
}

resource "google_compute_target_http_proxy" "default" {
  name = "cdn-target-http-proxy-basic"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_global_forwarding_rule" "default" {
  name = "cdn-global-forwarding-rule-basic"
  ip_protocol = "TCP"
  load_balancing_scheme = "INTERNAL"
  port_range = "80"
  target = google_compute_target_http_proxy.default.id
}

resource "google_compute_region_backend_service" "default" {
  name = "vision-backend-service-basic"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  health_checks = [google_compute_health_check.default.id]
  load_balancing_scheme = "INTERNAL"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  health_checks = [google_compute_health_check.default.id]
  load_balancing_scheme = "INTERNAL"
}

resource "google_compute_health_check" "default" {
  name = "vision-health-check-basic"
  check_interval_sec = 5
  timeout_sec = 5
  healthy_threshold = 2
  unhealthy_threshold = 2
  http_health_check {
    host = "localhost"
    port = 80
    request_path = "/"
  }
}

resource "google_compute_target_http_proxy" "default" {
  name = "vision-target-http-proxy-basic"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_global_forwarding_rule" "default" {
  name = "vision-global-forwarding-rule-basic"
  ip_protocol = "TCP"
  load_balancing_scheme = "INTERNAL"
  port_range = "80"
  target = google_compute_target_http_proxy.default.id
}

resource "google_service_account" "default" {
  account_id   = "vision-sa-basic"
  display_name = "Vision Service Account"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/vision.user"
  member  = "serviceAccount:${google_service_account.default.email}"
}

resource "google_project_service" "default" {
  disable_on_destroy = false
  name                = "vision-api-basic"
  service             = "vision.googleapis.com"
}
