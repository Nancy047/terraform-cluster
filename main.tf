
# Configure the Google Cloud Provider
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

# Resource configuration for Gemini for Google Cloud
resource "google_ai_platform_model" "gemini_model" {
  name     = "gemini-model"
  location = "us-central1"
  display_name = "Gemini Model"
  description = "Gemini model for Google Cloud"
  version_description = "Initial version"
  version {
    name = "v1"
    training_version {
      training_input {
        # Replace with your actual training data
        training_data_uri = "gs://your-bucket/training-data.csv"
      }
    }
  }
}

resource "google_ai_platform_endpoint" "gemini_endpoint" {
  name     = "gemini-endpoint"
  location = "us-central1"
  display_name = "Gemini Endpoint"
  description = "Endpoint for Gemini model"
  machine_type = "n1-standard-1"
  min_replica_count = 1
  max_replica_count = 2
  model {
    name = google_ai_platform_model.gemini_model.name
    version = google_ai_platform_model.gemini_model.version.0.name
  }
}
