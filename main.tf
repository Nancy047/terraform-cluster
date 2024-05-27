
provider "google" {
  credentials = file("credentials.json")
  project     = "testproject"
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
