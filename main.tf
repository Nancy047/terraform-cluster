
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

# Network Intelligence Center
resource "google_network_intelligence_center_config" "nic_config" {
  name     = "nic-config"
  location = "us-central1"
  config {
    enable_network_visibility = true
    enable_flow_logs           = true
    enable_security_health     = true
    enable_threat_detection    = true
  }
}

resource "google_network_intelligence_center_location_config" "nic_location_config" {
  name     = "nic-location-config"
  location = "us-central1"
  config {
    enable_network_visibility = true
    enable_flow_logs           = true
    enable_security_health     = true
    enable_threat_detection    = true
  }
}

