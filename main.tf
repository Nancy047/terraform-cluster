
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
  project     = "my-project"
}

resource "google_storage_bucket" "default" {
  name           = "my-buc"
  location       = "us-central1"
  storage_class  = "STANDARD"
  uniform_bucket_level_access = true
}
