
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

resource "google_project_service" "default" {
  service = "cloudkms.googleapis.com"
  disable = false
}

resource "google_kms_crypto_key" "default" {
  purpose = "ENCRYPT_DECRYPT"
  name    = "crypto-key-basic"
  key_ring {
    name = "key-ring-basic"
  }
  rotation_period = "86400s"
  version_template {
    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
  }
}

resource "google_kms_key_ring" "default" {
  name    = "key-ring-basic"
  location = "us-central1"
}

resource "google_pubsub_topic" "default" {
  name     = "pubsub-topic-basic"
  project  = "abc"
  labels = {
    environment = "dev"
  }
}

resource "google_pubsub_subscription" "default" {
  name     = "pubsub-subscription-basic"
  topic    = google_pubsub_topic.default.id
  project  = "abc"
  ack_deadline_seconds = 10
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

resource "google_app_engine_application" "default" {
  location_id = "us-central1"
  project     = "abc"
}

resource "google_app_engine_service" "default" {
  name     = "app-engine-service-basic"
  application = google_app_engine_application.default.name
  location_id = "us-central1"
  runtime = "nodejs16"
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

resource "google_cloudfunctions2_function" "default" {
  name     = "cloud-function2-basic"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = google_storage_bucket.default.name
  source_archive_object = "function.zip"
  event_trigger {
    event_type = "google.cloud.storage.object.v1.finalized"
    event_filters {
      resource {
        service = "storage.googleapis.com"
        name    = google_storage_bucket.default.name
      }
    }
  }
  region = "us-central1"
}

resource "google_cloud_run_v2_service" "default" {
  name     = "cloud-run-service-basic"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
}

resource "google_container_cluster" "default" {
  name     = "container-cluster-basic"
  location = "us-central1-a"
  initial_node_count = 1
  node_config {
    machine_type = "e2-medium"
  }
  master_auth {
    username = "admin"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "container-node-pool-basic"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 1
  node_config {
    machine_type = "e2-medium"
  }
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-container-cluster-basic.iam.gserviceaccount.com"
}

resource "google_project_service" "default" {
  service = "container.googleapis.com"
  disable = false
}

resource "google_project_service" "default" {
  service = "run.googleapis.com"
  disable = false
}

resource "google_project_service" "default" {
  service = "cloudfunctions.googleapis.com"
  disable = false
}

resource "google_project_service" "default" {
  service = "cloudfunctions2.googleapis.com"
  disable = false
}

resource "google_project_service" "default" {
  service = "bigquery.googleapis.com"
  disable = false
}

resource "google_project_service" "default" {
  service = "pubsub.googleapis.com"
  disable = false
}

resource "google_project_service" "default" {
  service = "kms.googleapis.com"
  disable = false
}

resource "google_project_service" "default" {
  service = "storage.googleapis.com"
  disable = false
}

resource "google_project_service" "default" {
  service = "sqladmin.googleapis.com"
  disable = false
}

resource "google_project_service" "default" {
  service = "compute.googleapis.com"
  disable = false
}
