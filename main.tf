
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

resource "google_sql_database" "default" {
  name     = "[database_name]"
  instance = "[instance_name]"
  charset  = "UTF8"
}

resource "google_sql_user" "default" {
  name     = "[user_name]"
  instance = "[instance_name]"
  password = "[password]"
}

resource "google_storage_bucket" "default" {
  name     = "[bucket_name]"
  location = "US"
  force_destroy = true
}

resource "google_storage_bucket_object" "default" {
  name   = "[object_name]"
  bucket = "[bucket_name]"
  source = "[file_path]"
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
  entry_point = "[entry_point]"
  source_archive_bucket = "[bucket_name]"
  source_archive_object = "[object_name]"
  trigger_http = true
  project = "abc"
}

resource "google_bigquery_dataset" "default" {
  dataset_id = "[dataset_name]"
  location    = "US"
  project     = "abc"
}

resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "[table_name]"
  project     = "abc"
  schema      = <<EOF
[schema]
EOF
}

resource "google_pubsub_topic" "default" {
  name     = "[topic_name]"
  project = "abc"
}

resource "google_pubsub_subscription" "default" {
  name     = "[subscription_name]"
  topic    = google_pubsub_topic.default.name
  project = "abc"
}

resource "google_kms_crypto_key" "default" {
  name     = "[key_name]"
  purpose  = "ENCRYPT_DECRYPT"
  rotation_period = "86400s"
  version_template {
    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
  }
  project = "abc"
  location = "us-central1"
  key_ring = "[key_ring_name]"
}

resource "google_kms_key_ring" "default" {
  name     = "[key_ring_name]"
  location = "us-central1"
  project = "abc"
}

resource "google_cloud_run_v2_service" "default" {
  name     = "[service_name]"
  location = "us-central1"
  template {
    containers {
      image = "[image_name]"
    }
  }
  project = "abc"
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "[image_name]"
    }
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
  project = "abc"
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
  project = "abc"
}

resource "google_cloud_run_v2_