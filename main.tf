
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.22.0"
    }
  }
}

provider "google" {
  credentials = "path/to/credentials.json"
  project     = "lumen-b-ctl-047"
}

resource "google_storage_bucket" "my-bucket" {
  name          = "my-bucket"
  location      = "US-CENTRAL1"
  storage_class = "STANDARD"
 uniform_bucket_level_access = true
}
