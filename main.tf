
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
    tier = "db-f1-micro"
  }
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/storage.objectViewer"
  member  = "user:user@example.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:service-account@gcp-sa-project-id.iam.gserviceaccount.com"
}

resource "google_