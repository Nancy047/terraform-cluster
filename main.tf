
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

resource "google_pubsub_topic" "default" {
  name     = "pubsub-topic-basic"
  project  = "abc"
  location = "us-central1"
}

resource "google_cloudfunctions_function" "default" {
  name     = "cloud-function-basic"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = "gs://[bucket_name]"
  source_archive_object = "[object_name]"
  trigger_http = true
  project  = "abc"
  region   = "us-central1"
}

resource "google_cloud_run_v2_service" "default" {
  name     = "cloud-run-basic"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/[project_id]/[repo_name]/[image_name]"
    }
  }
  project = "abc"
}
