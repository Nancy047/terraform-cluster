
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
    machine_type = "e2-medium"
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
  cluster  = "b"
  granularity = "MILLIS"
  split_keys = ["0", "1", "2"]
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
  project = "gcp-project-id"
}

resource "google_app_engine_service" "default" {
  name     = "[service_name]"
  application = google_app_engine_application.default.name
  location_id = "us-central1"
  runtime = "nodejs16"
  entry_point = "helloHTTP"
  env = "standard"
}

resource "google_kms_crypto_key" "default" {
  name     = "[key_name]"
  purpose  = "ENCRYPT_DECRYPT"
  rotation_period = "86400s"
  version_template {
    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
  }
  key_ring = "projects/gcp-project-id/locations/us-central1/keyRings/default"
}

resource "google_kms_crypto_key_iam_member" "default" {
  crypto_key = google_kms_crypto_key.default.id
  role        = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member      = "user:user@example.com"
}

resource "google_cloud_run_v2_service" "default" {
  name     = "[service_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
    route_region = "us-central1"
    route_project = "gcp-project-id"
    route_tag = "latest"
    route_type = "INGRESS"
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "[job_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_task" "default" {
  name     = "[task_name]"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "[domain_mapping_name]"
  location = "us-central1"
  spec