
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

resource "google_storage_bucket" "chatbot_terraform_bucket" {
  name           = "chatbot-terraform-bucket"
  location       = "us-central1"
  storage_class  = "STANDARD"
  uniform_bucket_level_access = false
}
