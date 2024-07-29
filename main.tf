
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
  disable_on_destroy = false
}

resource "google_kms_crypto_key" "default" {
  purpose = "ENCRYPT_DECRYPT"
  name    = "crypto-key-basic"
  key_ring {
    name = "key-ring-basic"
    location = "us-central1"
  }
}

resource "google_kms_key_ring" "default" {
  name     = "key-ring-basic"
  location = "us-central1"
}

resource "google_pubsub_topic" "default" {
  name = "pubsub-topic-basic"
}

resource "google_pubsub_subscription" "default" {
  name    = "pubsub-subscription-basic"
  topic   = google_pubsub_topic.default.id
  ack_deadline_seconds = 10
}

resource "google_bigquery_dataset" "default" {
  dataset_id = "bigquery-dataset-basic"
  location    = "US"
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
  source_archive_bucket = "storage-bucket-basic"
  source_archive_object = "function.zip"
  trigger_http = true
  region = "us-central1"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.invoker"
  member   = "user:user@example.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account-basic@gcp-sa-bigquery.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "service-account-basic"
  display_name = "Service Account Basic"
  disabled     = false
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.