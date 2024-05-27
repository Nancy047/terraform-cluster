
provider "google" {
  credentials_file = "path/to/credentials.json"
  project     = "sampleproject"
}

resource "google_container_cluster" "primary" {
  name     = "test-cluster"
  location = "us-central1-c"

  initial_node_count = 2

 node_config {
    machine_type = "e2-medium"
  }
  remove_default_node_pool = true

}

resource "google_container_node_pool" "nodes" {
  name       = "primary-nodes"
  location  = "us-central1-c"
  cluster   = google_container_cluster.primary.name
  node_count = 2

  node_config {
    machine_type = "e2-medium"
  }
}
