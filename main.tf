
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
  subnetwork = "projects/[project_id]/regions/us-central1/subnetworks/default"
}

resource "google_storage_bucket" "default" {
  name     = "[bucket_name]"
  location = "US"
  force_destroy = true
  storage_class = "STANDARD"
}

resource "google_sql_database" "default" {
  name     = "[database_name]"
  instance = google_sql_database_instance.default.name
}

resource "google_sql_database_instance" "default" {
  name             = "[instance_name]"
  database_version = "MYSQL_5_7"
  region           = "us-central1"
  settings {
    tier = "db-custom-1-3840"
  }
}

resource "google_pubsub_topic" "default" {
  name     = "[topic_name]"
  project  = "abc"
  location = "us-central1"
}

resource "google_bigquery_dataset" "default" {
  dataset_id = "[dataset_name]"
  location    = "US"
  delete_contents_on_destroy = true
}

resource "google_bigtable_instance" "default" {
  name     = "[instance_name]"
  display_name = "[instance_name]"
  location = "us-central1"
  cluster {
    name = "[cluster_name]"
    nodes = 3
    zone = "us-central1-a"
  }
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/owner"
  member  = "user:[user_email]"
}

resource "google_project_service" "default" {
  service = "cloudkms.googleapis.com"
  disable_on_destroy = false
}

resource "google_kms_crypto_key" "default" {
  purpose = "ENCRYPT_DECRYPT"
  key_ring = google_kms_key_ring.default.id
  version_template {
    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
  }
}

resource "google_kms_key_ring" "default" {
  location = "us-central1"
  name     = "[key_ring_name]"
  project  = "abc"
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

resource "google_app_engine_application" "default" {
  location_id = "us-central1"
  project     = "abc"
  name        = "[app_name]"
}

resource "google_app_engine_service" "default" {
  name     = "[service_name]"
  application = google_app_engine_application.default.name
  location = "us-central1"
}

resource "google_cloud_run_v2_service" "default" {
  name     = "[service_name]"
  location = "us-central1"
  template {
    containers {
      image = "[image_name]"
    }
  }
  autogenerate_revision_name = true
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "[image_name]"
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_run_v2_ingress" "default" {
  name     = "[ingress_name]"
  location = "us-central1"
  spec {
    visibility = "INTERNAL"
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_cloud_