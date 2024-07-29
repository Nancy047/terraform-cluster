
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

# Configure Firebase Authentication
resource "google_firebase_project" "default" {
  project_id = "your-project-id"
}

resource "google_firebase_auth_provider" "default" {
  project = google_firebase_project.default.project_id
  provider {
    uid = "google.com"
    display_name = "Google"
  }
}

resource "google_firebase_auth_provider" "email" {
  project = google_firebase_project.default.project_id
  provider {
    uid = "password"
    display_name = "Email/Password"
  }
}

resource "google_firebase_auth_provider" "phone" {
  project = google_firebase_project.default.project_id
  provider {
    uid = "phone"
    display_name = "Phone"
  }
}

resource "google_firebase_auth_provider" "anonymous" {
  project = google_firebase_project.default.project_id
  provider {
    uid = "anonymous"
    display_name = "Anonymous"
  }
}

