
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
  name         = "vm-instance-medium"
  machine_type = "n1-standard-1"
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
  name     = "sql-database-medium"
  instance = "sql-instance-medium"
}

resource "google_sql_database_instance" "default" {
  name             = "sql-instance-medium"
  database_version = "MYSQL_5_7"
  region           = "us-central1"
  settings {
    tier = "db-custom-1-3840"
  }
}

resource "google_storage_bucket" "default" {
  name     = "storage-bucket-medium"
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
  name     = "kms-key-medium"
  purpose  = "ENCRYPT_DECRYPT"
  rotation_period = "86400s"
  key_ring {
    name = "kms-key-ring-medium"
  }
}

resource "google_kms_key_ring" "default" {
  name     = "kms-key-ring-medium"
  location = "us-central1"
}

resource "google_pubsub_topic" "default" {
  name     = "pubsub-topic-medium"
  project  = "abc"
  labels = {
    environment = "medium"
  }
}

resource "google_pubsub_subscription" "default" {
  name     = "pubsub-subscription-medium"
  topic    = google_pubsub_topic.default.id
  ack_deadline_seconds = 10
}

resource "google_bigquery_dataset" "default" {
  dataset_id = "bigquery-dataset-medium"
  location    = "US"
  delete_contents_on_destroy = true
}

resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "bigquery-table-medium"
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
  name     = "appengine-service-medium"
  location = "us-central1"
  application = google_app_engine_application.default.name
}

resource "google_cloudfunctions_function" "default" {
  name     = "cloudfunctions-function-medium"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = google_storage_bucket.default.name
  source_archive_object = "function.zip"
  trigger_http = true
  region = "us-central1"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.invoker"
  member   = "user:user@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.admin"
  member   = "user:user@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.developer"
  member   = "user:user@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.viewer"
  member   = "user:user@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.invoker"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.admin"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.developer"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.viewer"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.invoker"
  member   = "group:group@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.admin"
  member   = "group:group@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.developer"
  member   = "group:group@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.viewer"
  member   = "group:group@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.invoker"
  member   = "domain:domain.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.admin"
  member   = "domain:domain.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.developer"
  member   = "domain:domain.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.viewer"
  member   = "domain:domain.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.invoker"
  member   = "user:user@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.admin"
  member   = "user:user@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.developer"
  member   = "user:user@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.viewer"
  member   = "user:user@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.invoker"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.admin"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.developer"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.viewer"
  member   = "serviceAccount:service-1234567890@gcp-sa-cloudfunctions.iam.gserviceaccount.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.invoker"
  member   = "group:group@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.admin"
  member   = "group:group@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.developer"
  member   = "group:group@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.viewer"
  member   = "group:group@example.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.invoker"
  member   = "domain:domain.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.admin"
  member   = "domain:domain.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.developer"
  member   = "domain:domain.com"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.viewer"
  member   = "domain:domain.com"
}

resource "google_container_cluster" "default" {
  name     = "kubernetes-cluster-medium"
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
  master_auth {
    username = "admin"
  }
  subnetwork = "projects/abc/regions/us-central1/subnetworks/default"
  network = "projects/abc/global/networks/default"
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "node-pool-medium"
