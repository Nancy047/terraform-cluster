
terraform {
  required_providers {
    google = {
      version = "5.22.0"
    }
  }
}

provider "google" {
  credentials_file = "path-to-credentials-file.json"
  project          = "lumen-b-ctl-047"
}

resource "google_storage_bucket" "bucket" {
  name          = "my-bucket1"
  location      = "US-CENTRAL1"
 storage_class = "STANDARD"
  force_destroy = false
 uniform_bucket_level_access = true
}
