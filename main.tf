
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
  name         = "vm-basic"
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

resource "google_storage_bucket" "default" {
  name     = "bucket-basic"
  location = "US"
  force_destroy = true
}

resource "google_sql_database" "default" {
  name     = "db-basic"
  instance = "instance-basic"
  project  = "abc"
}

resource "google_sql_database_instance" "default" {
  name         = "instance-basic"
  database_version = "MYSQL_5_7"
  region        = "us-central1"
  settings {
    tier = "db-custom-1-3840"
  }
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
  key_ring = "key-ring-basic"
  name     = "key-basic"
  rotation_period = "86400s"
  version_template {
    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
  }
}

resource "google_kms_key_ring" "default" {
  location = "us-central1"
  name     = "key-ring-basic"
  project  = "abc"
}

resource "google_pubsub_topic" "default" {
  name     = "topic-basic"
  project  = "abc"
  labels = {
    env = "dev"
  }
}

resource "google_bigquery_dataset" "default" {
  dataset_id = "dataset-basic"
  location    = "US"
  project     = "abc"
  default_table_expiration_ms = 2592000000
  default_partition_expiration_ms = 2592000000
}

resource "google_bigquery_table" "default" {
  dataset_id = "dataset-basic"
  table_id   = "table-basic"
  project     = "abc"
  time_partitioning {
    type = "DAY"
  }
}

resource "google_app_engine_application" "default" {
  location_id = "us-central1"
  project     = "abc"
}

resource "google_app_engine_service" "default" {
  name     = "service-basic"
  application = google_app_engine_application.default.name
  project     = "abc"
}

resource "google_cloudfunctions_function" "default" {
  name     = "function-basic"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = google_storage_bucket.default.name
  source_archive_object = "function.zip"
  trigger_http = true
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.invoker"
  member   = "user:user@example.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.admin"
  member   = "user:user@example.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.developer"
  member   = "user:user@example.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.viewer"
  member   = "user:user@example.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.serviceAgent"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
  project  = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/iam.serviceAccountTokenCreator"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserv