
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
  machine_type = "e2-medium"
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

resource "google_container_cluster" "default" {
  name     = "[cluster_name]"
  location = "us-central1"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
  master_auth {
    username = "admin"
  }
  subnetwork = "projects/gcp-project-id/regions/us-central1/subnetworks/default"
}

resource "google_storage_bucket" "default" {
  name     = "[bucket_name]"
  location = "US"
  force_destroy = true
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_sql_database" "default" {
  name     = "[database_name]"
  instance = "gcp-project-id:us-central1:instance-name"
}

resource "google_sql_user" "default" {
  name     = "[user_name]"
  instance = "gcp-project-id:us-central1:instance-name"
  password = "password"
}

resource "google_pubsub_topic" "default" {
  name     = "[topic_name]"
  project  = "gcp-project-id"
  labels = {
    environment = "dev"
  }
}

resource "google_bigquery_dataset" "default" {
  dataset_id = "[dataset_name]"
  location    = "US"
  delete_contents_on_destroy = false
}

resource "google_bigtable_instance" "default" {
  name     = "[instance_name]"
  display_name = "[instance_name]"
  location = "us-central1"
}

resource "google_bigtable_table" "default" {
  name     = "[table_name]"
  instance = google_bigtable_instance.default.name
  cluster  = "cluster-name"
  column_families {
    name = "cf1"
    gc_rule {
      max_age {
        seconds = 3600
      }
    }
  }
}

resource "google_app_engine_application" "default" {
  location_id = "us-central1"
  project     = "gcp-project-id"
}

resource "google_app_engine_service" "default" {
  name     = "[service_name]"
  application = google_app_engine_application.default.name
  location_id = "us-central1"
  runtime = "nodejs16"
}

resource "google_cloudfunctions_function" "default" {
  name     = "[function_name]"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = google_storage_bucket.default.name
  source_archive_object = "function.zip"
  trigger_http = true
  region = "us-central1"
}

resource "google_cloud_run_v2_service" "default" {
  name     = "[service_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
}

resource "google_kms_crypto_key" "default" {
  name     = "[key_name]"
  purpose  = "ENCRYPT_DECRYPT"
  rotation_period = "86400s"
  version_template {
    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
  }
  key_ring = google_kms_key_ring.default.id
}

resource "google_kms_key_ring" "default" {
  name     = "[key_ring_name]"
  location = "us-central1"
  project  = "gcp-project-id"
}

resource "google_project_iam_member" "default" {
  project = "gcp-project-id"
  role    = "roles/owner"
  member  = "user:user@example.com"
}

resource "google_project_service" "default" {
  service = "cloudkms.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "storage.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "cloudfunctions.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "pubsub.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "bigquery.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "bigtable.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "iam.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "sqladmin.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "container.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "appengine.googleapis.com"
  disable_on_destroy = false
}
