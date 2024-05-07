# Create the GKE cluster
resource "google_container_cluster" "cluster" {
  name               = var.cluster_name
  location           = var.region
  initial_node_count = var.initial_node_count

  remove_default_node_pool = true

  # Node pool configuration
  node_pool {
    name         = "default-pool"
    machine_type = var.node_machine_type
    node_count   = var.initial_node_count
  }
}
