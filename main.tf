
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
  name         = "vm-instance-basic"
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

resource "google_sql_database" "default" {
  name     = "sql-database-basic"
  instance = "sql-instance-basic"
  charset  = "UTF8"
}

resource "google_sql_database_instance" "default" {
  name             = "sql-instance-basic"
  database_version = "MYSQL_5_7"
  region           = "us-central1"
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_storage_bucket" "default" {
  name     = "storage-bucket-basic"
  location = "US"
  force_destroy = true
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/storage.objectViewer"
  member  = "user:user@example.com"
}

resource "google_app_engine_application" "default" {
  location_id = "us-central1"
  name        = "app-engine-application-basic"
}

resource "google_app_engine_service" "default" {
  name     = "app-engine-service-basic"
  location = "us-central1"
  application = google_app_engine_application.default.name
}

resource "google_cloudfunctions_function" "default" {
  name     = "cloud-function-basic"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = google_storage_bucket.default.name
  source_archive_object = "function.zip"
  trigger_http = true
  region = "us-central1"
}

resource "google_bigquery_dataset" "default" {
  dataset_id = "bigquery-dataset-basic"
  location    = "US"
  delete_contents_on_destroy = true
}

resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "bigquery-table-basic"
  schema     = <<EOF
[
  {
    "name": "name",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "age",
    "type": "INTEGER",
    "mode": "NULLABLE"
  }
]
EOF
}

resource "google_pubsub_topic" "default" {
  name     = "pubsub-topic-basic"
  project  = "abc"
  location = "us-central1"
}

resource "google_pubsub_subscription" "default" {
  name     = "pubsub-subscription-basic"
  topic    = google_pubsub_topic.default.name
  project  = "abc"
  location = "us-central1"
}

resource "google_kms_crypto_key" "default" {
  name     = "kms-key-basic"
  purpose  = "ENCRYPT_DECRYPT"
  rotation_period = "86400s"
  version_template {
    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
  }
  key_ring = google_kms_key_ring.default.id
}

resource "google_kms_key_ring" "default" {
  name     = "kms-key-ring-basic"
  location = "us-central1"
  project  = "abc"
}

resource "google_container_cluster" "default" {
  name     = "kubernetes-cluster-basic"
  location = "us-central1-a"
  initial_node_count = 1
  node_config {
    machine_type = "e2-medium"
  }
  master_auth {
    username = "admin"
  }
  network = "default"
}

resource "google_container_cluster_node_pool" "default" {
  name     = "kubernetes-node-pool-basic"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 1
  node_config {
    machine_type = "e2-medium"
  }
}

resource "google_project_service" "default" {
  service = "cloudkms.googleapis.com"
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
  service = "cloudfunctions.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "appengine.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "storage.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "sqladmin.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "default" {
  service = "container.googleapis.com"
  disable_on_destroy = false
}
