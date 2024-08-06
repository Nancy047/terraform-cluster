
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

# Database Migration Service
resource "google_sql_database_migration_service" "basic_dms" {
  name     = "basic-dms"
  location = "us-central1"
  # Basic usage: Use the default settings for the service.
}
