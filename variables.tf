variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
}

variable "region" {
  description = "The region where the GKE cluster will be located"
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "initial_node_count" {
  description = "The initial number of nodes in the GKE cluster"
  type        = number
}

variable "node_machine_type" {
  description = "The machine type for the nodes in the GKE cluster"
  type        = string
}
