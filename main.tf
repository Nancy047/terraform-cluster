
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

resource "google_sql_database" "default" {
  name     = "db-basic"
  instance = "instance-basic"
  project  = "abc"
}

resource "google_sql_database_instance" "default" {
  name         = "instance-basic"
  database_version = "MYSQL_5_7"
  region       = "us-central1"
  settings {
    tier = "db-custom-1-3840"
  }
}

resource "google_storage_bucket" "default" {
  name     = "bucket-basic"
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
  name    = "key-basic"
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
  name     = "topic-basic"
  project  = "abc"
  labels = {
    environment = "dev"
  }
}

resource "google_pubsub_subscription" "default" {
  name     = "subscription-basic"
  topic    = google_pubsub_topic.default.id
  project  = "abc"
  ack_deadline_seconds = 10
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
  project = "abc"
  role    = "roles/cloudfunctions.invoker"
  member  = "user:user@example.com"
  function = google_cloudfunctions_function.default.name
}

resource "google_bigquery_dataset" "default" {
  dataset_id = "dataset-basic"
  project     = "abc"
  location    = "US"
}

resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "table-basic"
  project     = "abc"
  schema = <<EOF
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

resource "google_bigquery_table_iam_member" "default" {
  project = "abc"
  role    = "roles/bigquery.dataViewer"
  member  = "user:user@example.com"
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = google_bigquery_table.default.table_id
}

resource "google_container_cluster" "default" {
  name     = "cluster-basic"
  location = "us-central1-a"
  initial_node_count = 1
  node_config {
    machine_type = "e2-medium"
  }
  project = "abc"
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-basic"
  cluster = google_container_cluster.default.name
  location = google_container_cluster.default.location
  initial_node_count = 1
  node_config {
    machine_type = "e2-medium"
  }
  project = "abc"
}

resource "google_container_cluster_iam_member" "default" {
  project = "abc"
  role    = "roles/container.admin"
  member  = "user:user@example.com"
  cluster = google_container_cluster.default.name
  location = google_container_cluster.default.location
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-container.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-kubernetes.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudrun.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-cloudtasks.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-