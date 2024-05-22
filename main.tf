
terraform {
  required_providers {
    google = {
      version = "5.22"
    }
  }
}

provider "google" {
  credentials_file = "credentials.json"
  project = "lumen-b-ctl-047"
}

resource "google_storage_bucket" "bucket" {
  name          = "my-bucket"
  location      = "US-CENTRAL1"
  force_destroy = false
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}
