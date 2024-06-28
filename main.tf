
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
  machine_type = "e2-micro"
  zone         = "[location]"
  boot_disk {
    initialize_params {
      image = "[boot_disk_image]"
    }
  }
  network_interface {
    network = "default"
  }
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
  instance = "[instance_name]"
}

resource "google_sql_user" "default" {
  name     = "[user_name]"
  instance = "[instance_name]"
  password = "[password]"
}

resource "google_sql_database_instance" "default" {
  name             = "[instance_name]"
  database_version = "MYSQL_5_7"
  region           = "us-central1"
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_pubsub_topic" "default" {
  name     = "[topic_name]"
  project  = "abc"
  labels = {
    environment = "dev"
  }
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/owner"
  member  = "user:[user_email]"
}

resource "google_project_service" "default" {
  service = "cloudkms.googleapis.com"
  disable = false
}

resource "google_kms_crypto_key" "default" {
  purpose = "ENCRYPT_DECRYPT"
  key_ring = "projects/[project_id]/locations/[location]/keyRings/[key_ring_name]"
  version_template {
    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
  }
}

resource "google_kms_key_ring" "default" {
  location = "[location]"
  name     = "[key_ring_name]"
  project  = "abc"
}

resource "google_app_engine_application" "default" {
  location_id = "us-central1"
  project     = "abc"
}

resource "google_app_engine_service" "default" {
  name     = "[service_name]"
  location = "us-central1"
  application = google_app_engine_application.default.name
}

resource "google_cloudfunctions_function" "default" {
  name     = "[function_name]"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = google_storage_bucket.default.name
  source_archive_object = "function.zip"
  trigger_http = true
  project = "abc"
}

resource "google_cloudfunctions_function_iam_member" "default" {
  function = google_cloudfunctions_function.default.name
  role     = "roles/cloudfunctions.invoker"
  member   = "allUsers"
  project  = "abc"
}

resource "google_bigquery_dataset" "default" {
  dataset_id = "[dataset_name]"
  location    = "US"
  project     = "abc"
  default_table_expiration_ms = 2592000000
  default_partition_expiration_ms = 2592000000
  default_table_labels = {
    environment = "dev"
  }
}

resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "[table_name]"
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
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = google_bigquery_table.default.table_id
  role       = "roles/bigquery.dataViewer"
  member     = "user:[user_email]"
  project    = "abc"
}

resource "google_bigquery_dataset_iam_member" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  role       = "roles/bigquery.dataViewer"
  member     = "user:[user_email]"
  project    = "abc"
}

resource "google_bigquery_data_transfer_config" "default" {
  display_name = "[transfer_config_name]"
  data_source_id = "google_sheets"
  destination_dataset_id = google_bigquery_dataset.default.dataset_id
  schedule = "every 24 hours"
  params {
    google_sheets_source_params {
      spreadsheet_id = "[spreadsheet_id]"
      sheet_id = "[sheet_id]"
    }
  }
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigEditor"
  member = "user:[user_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigViewer"
  member = "user:[user_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOperator"
  member = "user:[user_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigUser"
  member = "user:[user_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigAdmin"
  member = "user:[user_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOwner"
  member = "user:[user_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigEditor"
  member = "serviceAccount:[service_account_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigViewer"
  member = "serviceAccount:[service_account_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOperator"
  member = "serviceAccount:[service_account_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigUser"
  member = "serviceAccount:[service_account_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigAdmin"
  member = "serviceAccount:[service_account_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOwner"
  member = "serviceAccount:[service_account_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigEditor"
  member = "group:[group_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigViewer"
  member = "group:[group_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOperator"
  member = "group:[group_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigUser"
  member = "group:[group_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigAdmin"
  member = "group:[group_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOwner"
  member = "group:[group_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigEditor"
  member = "domain:[domain_name]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigViewer"
  member = "domain:[domain_name]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOperator"
  member = "domain:[domain_name]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigUser"
  member = "domain:[domain_name]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigAdmin"
  member = "domain:[domain_name]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOwner"
  member = "domain:[domain_name]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigEditor"
  member = "allUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigViewer"
  member = "allUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOperator"
  member = "allUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigUser"
  member = "allUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigAdmin"
  member = "allUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOwner"
  member = "allUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigEditor"
  member = "allAuthenticatedUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigViewer"
  member = "allAuthenticatedUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOperator"
  member = "allAuthenticatedUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigUser"
  member = "allAuthenticatedUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigAdmin"
  member = "allAuthenticatedUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOwner"
  member = "allAuthenticatedUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigEditor"
  member = "user:[user_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigViewer"
  member = "user:[user_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOperator"
  member = "user:[user_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigUser"
  member = "user:[user_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigAdmin"
  member = "user:[user_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOwner"
  member = "user:[user_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigEditor"
  member = "serviceAccount:[service_account_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigViewer"
  member = "serviceAccount:[service_account_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOperator"
  member = "serviceAccount:[service_account_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigUser"
  member = "serviceAccount:[service_account_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigAdmin"
  member = "serviceAccount:[service_account_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOwner"
  member = "serviceAccount:[service_account_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigEditor"
  member = "group:[group_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigViewer"
  member = "group:[group_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOperator"
  member = "group:[group_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigUser"
  member = "group:[group_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigAdmin"
  member = "group:[group_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOwner"
  member = "group:[group_email]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigEditor"
  member = "domain:[domain_name]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigViewer"
  member = "domain:[domain_name]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOperator"
  member = "domain:[domain_name]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigUser"
  member = "domain:[domain_name]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigAdmin"
  member = "domain:[domain_name]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOwner"
  member = "domain:[domain_name]"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigEditor"
  member = "allUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigViewer"
  member = "allUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOperator"
  member = "allUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigUser"
  member = "allUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigAdmin"
  member = "allUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOwner"
  member = "allUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigEditor"
  member = "allAuthenticatedUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigViewer"
  member = "allAuthenticatedUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOperator"
  member = "allAuthenticatedUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigUser"
  member = "allAuthenticatedUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigAdmin"
  member = "allAuthenticatedUsers"
  project = "abc"
}

resource "google_bigquery_data_transfer_config_iam_member" "default" {
  data_transfer_config = google_bigquery_data_transfer_config.default.name
  role = "roles/bigquery.dataTransferConfigOwner"
  member = "allAuthenticatedUsers"
  project = "abc"
}

resource "google_bigquery_job" "default" {
  project = "abc"
  priority = "BATCH"
  configuration {
    query {
      query = "SELECT * FROM [project_id:dataset_id.table_id]"
      use_legacy_sql = false
    }
  }
}

resource "google_bigquery_table_iam_member" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = google_bigquery_table.default.table_id
  role       = "roles/bigquery.dataViewer"
  member     = "user:[user_email]"
  project    = "abc"
}

resource "google_bigquery_dataset_iam_member" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  role       = "roles/bigquery.dataViewer"
  member     = "user:[user_email]"
  project    = "abc"
}

resource "google_bigquery_job" "default" {
  project = "abc"
  priority = "BATCH"
  configuration {
    load {
      source_format = "CSV"
      source_uris = ["gs://[bucket_name]/[file_name]"]
      destination_table {
        dataset_id = google_bigquery_dataset.default.dataset_id
        table_id   = google_bigquery_table.default.table_id
      }
      create_disposition = "CREATE_IF_NEEDED"
      write_disposition = "WRITE_TRUNCATE"
    }
  }
}

resource "google_bigquery_table_iam_member" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = google_bigquery_table.default.table_id
  role       = "roles/bigquery.dataViewer"
  member     = "user:[user_email]"
  project    = "abc"
}

resource "google_bigquery_dataset_iam_member" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  role       = "roles/bigquery.dataViewer"
  member     = "user:[user_email]"
  project    = "abc"
}

resource "google_bigquery_job" "default" {
  project = "abc"
  priority = "BATCH"
  configuration {
    extract {
      source_table {
        dataset_id = google_bigquery_dataset.default.dataset_id
        table_id   = google_bigquery_table.default.table_id
      }
      destination_uris = ["gs://[bucket_name]/[file_name]"]
      destination_format = "CSV"
    }
  }
}

resource "google_bigquery_table_iam_member" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = google_bigquery_table.default.table_id
  role       = "roles/bigquery.dataViewer"
  member     = "user:[user_email]"
  project    = "abc"
}

resource "google_bigquery_dataset_iam_member" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  role       = "roles/bigquery.dataViewer"
  member     = "user:[user_email]"
  project    = "abc"
}

resource "google_bigquery_job" "default" {
  project = "abc"
  priority = "BATCH"
  configuration {
    copy {
      source_table {
        dataset_id = google_bigquery_dataset.default.dataset_id
        table_id   = google_bigquery_table.default.table_id
      }
      destination_table {
        dataset_id = google_bigquery_dataset.default.dataset_id
        table_id   = "[table_name]"
      }
      create_disposition = "CREATE_IF_NEEDED"
      write_disposition = "WRITE_TRUNCATE"
    }
  }
}

resource "google_bigquery_table_iam_member" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = google_bigquery_table.default.table_id
  role       = "roles/bigquery.dataViewer"
  member     = "user:[user_email]"
  project    = "abc"
}

resource "google_bigquery_dataset_iam_member" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  role       = "roles/bigquery.dataViewer"
  member     = "user:[user_email]"
  project    = "abc"
}

resource