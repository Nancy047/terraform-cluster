
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  credentials = "keys.json"
  project     = "my-project"
}

resource "google_storage_bucket" "default" {
  name           = "my-bucket"
  location       = "us-central1"
  storage_class  = "STANDARD"
  uniform_bucket_level_access = false
}
