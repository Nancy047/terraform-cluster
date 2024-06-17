
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

resource "google_artifact_registry_repository" "default" {
  location = "us-central1"
  name     = "my-artifact"
  project  = "my-project"
}
