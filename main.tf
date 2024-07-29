
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

resource "google_compute_instance" "default" {
  name         = "vm-instance-basic"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  network_interface {
    network = "default"
  }
}

resource "google_sql_database" "default" {
  name     = "sql-database-basic"
  instance = "sql-instance-basic"
  charset  = "UTF8"
}

resource "google_sql_database_instance" "default" {
  name             = "sql-instance-basic"
  database_version = "MYSQL_5_7"
  region           = "us-central1"
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_storage_bucket" "default" {
  name     = "storage-bucket-basic"
  location = "US"
  force_destroy = true
}

resource "google_project_iam_member" "default" {
  project = "abc"
  role    = "roles/storage.objectViewer"
  member  = "user:user@example.com"
}

resource "google_project_service" "default" {
  service = "cloudkms.googleapis.com"
  disable = false
}

resource "google_kms_crypto_key" "default" {
  purpose = "ENCRYPT_DECRYPT"
  name    = "crypto-key-basic"
  key_ring = "key-ring-basic"
  location = "us-central1"
}

resource "google_kms_key_ring" "default" {
  name     = "key-ring-basic"
  location = "us-central1"
}

resource "google_pubsub_topic" "default" {
  name     = "pubsub-topic-basic"
  project  = "abc"
  labels = {
    environment = "dev"
  }
}

resource "google_pubsub_subscription" "default" {
  name     = "pubsub-subscription-basic"
  topic    = google_pubsub_topic.default.id
  project  = "abc"
  ack_deadline_seconds = 10
}

resource "google_app_engine_application" "default" {
  location_id = "us-central1"
  name        = "app-engine-application-basic"
}

resource "google_app_engine_service" "default" {
  name     = "app-engine-service-basic"
  location = "us-central1"
  application = google_app_engine_application.default.name
}

resource "google_cloudfunctions_function" "default" {
  name     = "cloud-function-basic"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = google_storage_bucket.default.name
  source_archive_object = "function.zip"
  trigger_http = true
  region = "us-central1"
}

resource "google_bigquery_dataset" "default" {
  dataset_id = "bigquery-dataset-basic"
  location    = "US"
  delete_contents_on_destroy = true
}

resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "bigquery-table-basic"
  location    = "US"
  schema = <<EOF
[
  {
    "name": "name",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "age",
    "type": "INTEGER",
    "mode": "NULLABLE"
  }
]
EOF
}

resource "google_container_cluster" "default" {
  name     = "container-cluster-basic"
  location = "us-central1-a"
  initial_node_count = 1
  node_config {
    machine_type = "e2-medium"
  }
  master_auth {
    username = "admin"
  }
}

resource "google_container_cluster_node_pool" "default" {
  name     = "container-node-pool-basic"
  cluster = google_container_cluster.default.name
  location = "us-central1-a"
  initial_node_count = 1
  node_config {
    machine_type = "e2-medium"
  }
}

resource "google_cloud_run_v2_service" "default" {
  name     = "cloud-run-service-basic"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
}

resource "google_cloud_run_v2_job" "default" {
  name     = "cloud-run-job-basic"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
}

resource "google_cloud_run_v2_domain_mapping" "default" {
  name     = "cloud-run-domain-mapping-basic"
  location = "us-central1"
  spec {
    route_name = google_cloud_run_v2_service.default.name
    route_kind = "Service"
  }
}

resource "google_compute_firewall" "default" {
  name    = "firewall-basic"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "default" {
  name    = "address-basic"
  address_type = "EXTERNAL"
  project = "abc"
  region = "us-central1"
}

resource "google_compute_forwarding_rule" "default" {
  name    = "forwarding-rule-basic"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_instance.default.self_link
  load_balancing_scheme = "INTERNAL"
  network = "default"
  region = "us-central1"
}

resource "google_compute_health_check" "default" {
  name    = "health-check-basic"
  check_interval_sec = 5
  timeout_sec        = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
  tcp_health_check {
    port_name = "http"
    port      = 80
  }
}

resource "google_compute_target_pool" "default" {
  name    = "target-pool-basic"
  region = "us-central1"
  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_backend_service" "default" {
  name    = "backend-service-basic"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 15
  health_checks = [google_compute_health_check.default.id]
  load_balancing_scheme = "INTERNAL"
  port = 80
  region = "us-central1"
}

resource "google_compute_url_map" "default" {
  name    = "url-map-basic"
  default_service = google_compute_backend_service.default.id
  host_rule {
    hosts = ["*"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name = "allpaths"
    default_service = google_compute_backend_service.default.id
  }
  region = "us-central1"
}

resource "google_compute_target_http_proxy" "default" {
  name    = "target-http-proxy-basic"
  url_map = google_compute_url_map.default.id
  region = "us-central1"
}

resource "google_compute_global_forwarding_rule" "default" {
  name    = "global-forwarding-rule-basic"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_target_http_proxy.default.id
  load_balancing_scheme = "INTERNAL"
  network = "default"
}

resource "google_compute_region_autoscaler" "default" {
  name    = "autoscaler-basic"
  project = "abc"
  region  = "us-central1"
  target  = google_compute_instance_group_manager.default.id
  autoscaling_policy {
    max_replicas = 10
    min_replicas = 1
    cooldown_period = 60
    cpu_utilization {
      predictive_method = "NONE"
      target = 0.5
    }
  }
}

resource "google_compute_instance_group_manager" "default" {
  name    = "instance-group-manager-basic"
  base_instance_name = "instance-group-manager-basic"
  version_name = "default"
  zone = "us-central1-a"
  list_managed_instances_results {
    instance_state = "STABLE"
  }
  auto_healing_policies {
    initial_delay_sec = 60
    health_check = google_compute_health_check.default.id
  }
  distribution_policy {
    zones = ["us-central1-a"]
  }
  target_size = 1
  target_pools = [google_compute_target_pool.default.id]
}

resource "google_compute_instance_template" "default" {
  name_prefix  = "instance-template-basic"
  machine_type = "e2-micro"
  network_interface {
    network = "default"
  }
  disk {
    source_image = "centos-cloud/centos-7"
    auto_delete  = true
    boot         = true
    type         = "PERSISTENT"
  }
  can_ip_forward = false
  confidential_instance_config {
    enable_confidential_compute = false
  }
  advanced_machine_features {
    enable_nested_virtualization = false
  }
  scheduling {
    automatic_restart = true
    on_host_maintenance = "MIGRATE"
    preemptible = false
  }
  project = "abc"
}

resource "google_compute_instance_from_template" "default" {
  name         = "instance-from-template-basic"
  zone         = "us-central1-a"
  source_instance_template = google_compute_instance_template.default.self_link
  network_interface {
    network = "default"
  }
  project = "abc"
}

resource "google_compute_network" "default" {
  name    = "network-basic"
  project = "abc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name    = "subnetwork-basic"
  ip_cidr_range = "10.128.0.0/20"
  region = "us-central1"
  project = "abc"
  network = google_compute_network.default.self_link
}

resource "google_compute_router" "default" {
  name    = "router-basic"
  project = "abc"
  region  = "us-central1"
  bgp {
    asn = 64512
  }
}

resource "google_compute_router_interface" "default" {
  name    = "router-interface-basic"
  project = "abc"
  region  = "us-central1"
  router  = google_compute_router.default.name
  subnetwork = google_compute_subnetwork.default.self_link
}

resource "google_compute_router_nat" "default" {
  name    = "router-nat-basic"
  project = "abc"
  region  = "us-central1"
  router  = google_compute_router.default.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option = "AUTO_ONLY"
}

resource "google_compute_vpn_gateway" "default" {
  name    = "vpn-gateway-basic"
  project = "abc"
  region  = "us-central1"
  network = "default"
}

resource "google_compute_vpn_tunnel" "default" {
  name    = "vpn-tunnel-basic"
  project = "abc"
  region  = "us-central1"
  vpn_gateway = google_compute_vpn_gateway.default.name
  peer_gcp_gateway = "projects/gcp-project-id/regions/us-central1/vpnGateways/vpn-gateway-basic"
  shared_secret = "secret"
}

resource "google_compute_address" "default" {
  name    = "address-basic"
  address_type = "EXTERNAL"
  project = "abc"
  region = "us-central1"
}

resource "google_compute_global_address" "default" {
  name    = "global-address-basic"
  address_type = "EXTERNAL"
  project = "abc"
}

resource "google_compute_global_forwarding_rule" "default" {
  name    = "global-forwarding-rule-basic"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_target_http_proxy.default.id
  load_balancing_scheme = "INTERNAL"
  network = "default"
}

resource "google_compute_region_autoscaler" "default" {
  name    = "autoscaler-basic"
  project = "abc"
  region  = "us-central1"
  target  = google_compute_instance_group_manager.default.id
  autoscaling_policy {
    max_replicas = 10
    min_replicas = 1
    cooldown_period = 60
    cpu_utilization {
      predictive_method = "NONE"
      target = 0.5
    }
  }
}

resource "google_compute_instance_group_manager" "default" {
  name    = "instance-group-manager-basic"
  base_instance_name = "instance-group-manager-basic"
  version_name = "default"
  zone = "us-central1-a"
  list_managed_instances_results {
    instance_state = "STABLE"
  }
  auto_healing_policies {
    initial_delay_sec = 60
    health_check = google_compute_health_check.default.id
  }
  distribution_policy {
    zones = ["us-central1-a"]
  }
  target_size = 1
  target_pools = [google_compute_target_pool.default.id]
}

resource "google_compute_instance_template" "default" {
  name_prefix  = "instance-template-basic"
  machine_type = "e2-micro"
  network_interface {
    network = "default"
  }
  disk {
    source_image = "centos-cloud/centos-7"
    auto_delete  = true
    boot         = true
    type         = "PERSISTENT"
  }
  can_ip_forward = false
  confidential_instance_config {
    enable_confidential_compute = false
  }
  advanced_machine_features {
    enable_nested_virtualization = false
  }
  scheduling {
    automatic_restart = true
    on_host_maintenance = "MIGRATE"
    preemptible = false
  }
  project = "abc"
}

resource "google_compute_instance_from_template" "default" {
  name         = "instance-from-template-basic"
  zone         = "us-central1-a"
  source_instance_template = google_compute_instance_template.default.self_link
  network_interface {
    network = "default"
  }
  project = "abc"
}

resource "google_compute_network" "default" {
  name    = "network-basic"
  project = "abc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name    = "subnetwork-basic"
  ip_cidr_range = "10.128.0.0/20"
  region = "us-central1"
  project = "abc"
  network = google_compute_network.default.self_link
}

resource "google_compute_router" "default" {
  name    = "router-basic"
  project = "abc"
  region  = "us-central1"
  bgp {
    asn = 64512
  }
}

resource "google_compute_router_interface" "default" {
  name    = "router-interface-basic"
  project = "abc"
  region  = "us-central1"
  router  = google_compute_router.default.name
  subnetwork = google_compute_subnetwork.default.self_link
}

resource "google_compute_router_nat" "default" {
  name    = "router-nat-basic"
  project = "abc"
  region  = "us-central1"
  router  = google_compute_router.default.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option = "AUTO_ONLY"
}

resource "google_compute_vpn_gateway" "default" {
  name    = "vpn-gateway-basic"
  project = "abc"
  region  = "us-central1"
  network = "default"
}

resource "google_compute_vpn_tunnel" "default" {
  name    = "vpn-tunnel-basic"
  project = "abc"
  region  = "us-central1"
  vpn_gateway = google_compute_vpn_gateway.default.name
  peer_gcp_gateway = "projects/gcp-project-id/regions/us-central1/vpnGateways/vpn-gateway-basic"
  shared_secret = "secret"
}

resource "google_compute_address" "default" {
  name    = "address-basic"
  address_type = "EXTERNAL"
  project = "abc"
  region = "us-central1"
}

resource "google_compute_global_address" "default" {
  name    = "global-address-basic"
  address_type = "EXTERNAL"
  project = "abc"
}

resource "google_compute_global_forwarding_rule" "default" {
  name    = "global-forwarding-rule-basic"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_target_http_proxy.default.id
  load_balancing_scheme = "INTERNAL"
  network = "default"
}

resource "google_compute_region_autoscaler" "default" {
  name    = "autoscaler-basic"
  project = "abc"
  region  = "us-central1"
  target  = google_compute_instance_group_manager.default.id
  autoscaling_policy {
    max_replicas = 10
    min_replicas = 1
    cooldown_period = 60
    cpu_utilization {
      predictive_method = "NONE"
      target = 0.5
    }
  }
}

resource "google_compute_instance_group_manager" "default" {
  name    = "instance-group-manager-basic"
  base_instance_name = "instance-group-manager-basic"
  version_name = "default"
  zone = "us-central1-a"
  list_managed_instances_results {
    instance_state = "STABLE"
  }
  auto_healing_policies {
    initial_delay_sec = 60
    health_check = google_compute_health_check.default.id
  }
  distribution_policy {
    zones = ["us-central1-a"]
  }
  target_size = 1
  target_pools = [google_compute_target_pool.default.id]
}

resource "google_compute_instance_template" "default" {
  name_prefix  = "instance-template-basic"
  machine_type = "e2-micro"
  network_interface {
    network = "default"
  }
  disk {
    source_image = "centos-cloud/centos-7"
    auto_delete  = true
    boot         = true
    type         = "PERSISTENT"
  }
  can_ip_forward = false
  confidential_instance_config {
    enable_confidential_compute = false
  }
  advanced_machine_features {
    enable_nested_virtualization = false
  }
  scheduling {
    automatic_restart = true
    on_host_maintenance = "MIGRATE"
    preemptible = false
  }
  project = "abc"
}

resource "google_compute_instance_from_template" "default" {
  name         = "instance-from-template-basic"
  zone         = "us-central1-a"
  source_instance_template = google_compute_instance_template.default.self_link
  network_interface {
    network = "default"
  }
  project = "abc"
}

resource "google_compute_network" "default" {
  name    = "network-basic"
  project = "abc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name    = "subnetwork-basic"
  ip_cidr_range = "10.128.0.0/20"
  region = "us-central1"
  project = "abc"
  network = google_compute_network.default.self_link
}

resource "google_compute_router" "default" {
  name    = "router-basic"
  project = "abc"
  region  = "us-central1"
  bgp {
    asn = 64512
  }
}

resource "google_compute_router_interface" "default" {
  name    = "router-interface-basic"
  project = "abc"
  region  = "us-central1"
  router  = google_compute_router.default.name
  subnetwork = google_compute_subnetwork.default.self_link
}

resource "google_compute_router_nat" "default" {
  name    = "router-nat-basic"
  project = "abc"
  region  = "us-central1"
  router  = google_compute_router.default.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option = "AUTO_ONLY"
}

resource "google_compute_vpn_gateway" "default" {
  name    = "vpn-gateway-basic"
  project = "abc"
  region  = "us-central1"
  network = "default"
}

resource "google_compute_vpn_tunnel" "default" {
  name    = "vpn-tunnel-basic"
  project = "abc"
  region  = "us-central1"
  vpn_gateway = google_compute_vpn_gateway.default.name
  peer_gcp_gateway = "projects/gcp-project-id/regions/us-central1/vpnGateways/vpn-gateway-basic"
  shared_secret = "secret"
}

resource "google_compute_address" "default" {
  name    = "address-basic"
  address_type = "EXTERNAL"
  project = "abc"
  region = "us-central1"
}

resource "google_compute_global_address" "default" {
  name    = "global-address-basic"
  address_type = "EXTERNAL"
  project = "abc"
}

resource "google_compute_global_forwarding_rule" "default" {
  name    = "global-forwarding-rule-basic"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_target_http_proxy.default.id
  load_balancing_scheme = "INTERNAL"
  network = "default"
}

resource "google_compute_region_autoscaler" "default" {
  name    = "autoscaler-basic"
  project = "abc"
  region  = "us-central1"
  target  = google_compute_instance_group_manager.default.id
  autoscaling_policy {
    max_replicas = 10
    min_replicas = 1
    cooldown_period = 60
    cpu_utilization {
      predictive_method = "NONE"
      target = 0.5
    }
  }
}

resource "google_compute_instance_group_manager" "default" {
  name    = "instance-group-manager-basic"
  base_instance_name = "instance-group-manager-basic"
  version_name = "default"
  zone = "us-central1-a"
  list_managed_instances_results {
    instance_state = "STABLE"
  }
  auto_healing_policies {
    initial_delay_sec = 60
    health_check = google_compute_health_check.default.id
  }
  distribution_policy {
    zones = ["us-central1-a"]
  }
  target_size = 1
  target_pools = [google_compute_target_pool.default.id]
}

resource "google_compute_instance_template" "default" {
  name_prefix  = "instance-template-basic"
  machine_type = "e2-micro"
  network_interface {
    network = "default"
  }
  disk {
    source_image = "centos-cloud/centos-7"
    auto_delete  = true
    boot         = true
    type         = "PERSISTENT"
  }
  can_ip_forward = false
  confidential_instance_config {
    enable_confidential_compute = false
  }
  advanced_machine_features {
    enable_nested_virtualization = false
  }
  scheduling {
    automatic_restart = true
    on_host_maintenance = "MIGRATE"
    preemptible = false
  }
  project = "abc"
}

resource "google_compute_instance_from_template" "default" {
  name         = "instance-from-template-basic"
  zone         = "us-central1-a"
  source_instance_template = google_compute_instance_template.default.self_link
  network_interface {
    network = "default"
  }
  project = "abc"
}

resource "google_compute_network" "default" {
  name    = "network-basic"
  project = "abc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name    = "subnetwork-basic"
  ip_cidr_range = "10.128.0.0/20"
  region = "us-central1"
  project = "abc"
  network = google_compute_network.default.self_link
}

resource "google_compute_router" "default" {
  name    = "router-basic"
  project = "abc"
  region  = "us-central1"
  bgp {
    asn = 64512
  }
}

resource "google_compute_router_interface" "default" {
  name    = "router-interface-basic"
  project = "abc"
  region  = "us-central1"
  router  = google_compute_router.default.name
  subnetwork = google_compute_subnetwork.default.self_link
}

resource "google_compute_router_nat" "default" {
  name    = "router-nat-basic"
  project = "abc"
  region  = "us-central1"
  router  = google_compute_router.default.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option = "AUTO_ONLY"
}

resource "google_compute_vpn_gateway" "default" {
  name    = "vpn-gateway-basic"
  project = "abc"
  region  = "us-central1"
  network = "default"
}

resource "google_compute_vpn_tunnel" "default" {
  name    = "vpn-tunnel-basic"
  project = "abc"
  region  = "us-central1"
  vpn_gateway = google_compute_vpn_gateway.default.name
  peer_gcp_gateway = "projects/gcp-project-id/regions/us-central1/vpnGateways/vpn-gateway-basic"
  shared_secret = "secret"
}

resource "google_compute_address" "default" {
  name    = "address-basic"
  address_type = "EXTERNAL"
  project = "abc"
  region = "us-central1"
}

resource "google_compute_global_address" "default" {
  name    = "global-address-basic"
  address_type = "EXTERNAL"
  project = "abc"
}

resource "google_compute_global_forwarding_rule" "default" {
  name    = "global-forwarding-rule-basic"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_target_http_proxy.default.id
  load_balancing_scheme = "INTERNAL"
  network = "default"
}

resource "google_compute_region_autoscaler" "default" {
  name    = "autoscaler-basic"
  project = "abc"
  region  = "us-central1"
  target  = google_compute_instance_group_manager.default.id
  autoscaling_policy {
    max_replicas = 10
    min_replicas = 1
    cooldown_period = 60
    cpu_utilization {
      predictive_method = "NONE"
      target = 0.5
    }
  }
}

resource "google_compute_instance_group_manager" "default" {
  name    = "instance-group-manager-basic"
  base_instance_name = "instance-group-manager-basic"
  version_name = "default"
  zone = "us-central1-a"
  list_managed_instances_results {
    instance_state = "STABLE"
  }
  auto_healing_policies {
    initial_delay_sec = 60
    health_check = google_compute_health_check.default.id
  }
  distribution_policy {
    zones = ["us-central1-a"]
  }
  target_size = 1
  target_pools = [google_compute_target_pool.default.id]
}

resource "google_compute_instance_template" "default" {
  name_prefix  = "instance-template-basic"
  machine_type = "e2-micro"
  network_interface {
    network = "default"
  }
  disk {
    source_image = "centos-cloud/centos-7"
    auto_delete  = true
    boot         = true
    type         = "PERSISTENT"
  }
  can_ip_forward = false
  confidential_instance_config {
    enable_confidential_compute = false
  }
  advanced_machine_features {
    enable_nested_virtualization = false
  }
  scheduling {
    automatic_restart = true
    on_host_maintenance = "MIGRATE"
    preemptible = false
  }
  project = "abc"
}

resource "google_compute_instance_from_template" "default" {
  name         = "instance-from-template-basic"
  zone         = "us-central1-a"
  source_instance_template = google_compute_instance_template.default.self_link
  network_interface {
    network = "default"
  }
  project = "abc"
}

resource "google_compute_network" "default" {
  name    = "network-basic"
  project = "abc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name    = "subnetwork-basic"
  ip_cidr_range = "10.128.0.0/20"
  region = "us-central1"
  project = "abc"
  network = google_compute_network.default.self_link
}

resource "google_compute_router" "default" {
  name    = "router-basic"
  project = "abc"
  region  = "us-central1"
  bgp {
    asn = 64512
  }
}

resource "