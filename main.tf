
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
  project     = "abc"
}

resource "google_storage_bucket" "default" {
  name     = "[bucket_name]"
  location = "US"
  storage_class = "STANDARD"
  force_destroy = false
  uniform_bucket_level_access =