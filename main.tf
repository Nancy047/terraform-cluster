
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
  project     = "lumen-b-ctl-047"
}

resource "google_artifact_registry_repository" "default" {
  location = "us-central1"
  name     = "my-registry"
  project  = "lumen-b-ctl-047"
}
