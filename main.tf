
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
    tier = "db-custom-1-3840"
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
  disable_on_destroy = false
}

resource "google_kms_crypto_key" "default" {
  purpose = "ENCRYPT_DECRYPT"
  name    = "crypto-key-basic"
  key_ring {
    name = "key-ring-basic"
    location = "us-central1"
  }
}

resource "google_kms_key_ring" "default" {
  name     = "key-ring-basic"
  location = "us-central1"
}

resource "google_pubsub_topic" "default" {
  name = "pubsub-topic-basic"
}

resource "google_pubsub_subscription" "default" {
  name    = "pubsub-subscription-basic"
  topic   = google_pubsub_topic.default.id
  ack_deadline_seconds = 10
}

resource "google_bigquery_dataset" "default" {
  dataset_id = "bigquery-dataset-basic"
  location    = "US"
}

resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "bigquery-table-basic"
  schema     = <<EOF
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
  source_archive_bucket = "storage-bucket-basic"
  source_archive_object = "function.zip"
  trigger_http = true
  region = "us-central1"
}

resource "google_cloudfunctions2_function" "default" {
  name     = "cloud-function2-basic"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = "storage-bucket-basic"
  source_archive_object = "function.zip"
  trigger_http = true
  location = "us-central1"
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

resource "google_compute_network" "default" {
  name     = "compute-network-basic"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name          = "compute-subnetwork-basic"
  ip_cidr_range = "10.128.0.0/20"
  region        = "us-central1"
  network       = google_compute_network.default.id
}

resource "google_compute_firewall" "default" {
  name    = "compute-firewall-basic"
  network = google_compute_network.default.id
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}

resource "google_compute_address" "default" {
  name   = "compute-address-basic"
  address_type = "EXTERNAL"
  region = "us-central1"
}

resource "google_compute_forwarding_rule" "default" {
  name   = "compute-forwarding-rule-basic"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_instance.default.self_link
  region      = "us-central1"
  load_balancing_scheme = "INTERNAL"
}

resource "google_compute_target_http_proxy" "default" {
  name = "compute-target-http-proxy-basic"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  name = "compute-url-map-basic"
  host_rule {
    hosts = ["*"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name = "allpaths"
    default_service = google_compute_backend_service.default.id
  }
}

resource "google_compute_backend_service" "default" {
  name = "compute-backend-service-basic"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_health_check" "default" {
  name     = "compute-health-check-basic"
  check_interval_sec = 5
  timeout_sec        = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
  http_health_check {
    port = 80
    request_path = "/"
  }
}

resource "google_compute_target_pool" "default" {
  name = "compute-target-pool-basic"
  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_instance_from_template" "default" {
  name         = "compute-instance-from-template-basic"
  zone         = "us-central1-a"
  machine_type = "e2-micro"
  source_instance_template = "projects/gcp-project-id/global/instanceTemplates/instance-template-basic"
  network_interface {
    network = "default"
  }
}

resource "google_compute_instance_template" "default" {
  name_prefix  = "instance-template-basic"
  machine_type = "e2-micro"
  disk {
    source_image = "centos-cloud/centos-7"
    auto_delete  = true
    boot         = true
    type         = "PERSISTENT"
  }
  network_interface {
    network = "default"
  }
}

resource "google_compute_disk" "default" {
  name         = "compute-disk-basic"
  size_gb      = 100
  type         = "pd-standard"
  zone         = "us-central1-a"
  source_image = "centos-cloud/centos-7"
}

resource "google_compute_snapshot" "default" {
  name   = "compute-snapshot-basic"
  disk  = google_compute_disk.default.self_link
  source_disk_id = google_compute_disk.default.id
}

resource "google_compute_image" "default" {
  name    = "compute-image-basic"
  source_snapshot = google_compute_snapshot.default.self_link
}

resource "google_compute_router" "default" {
  name     = "compute-router-basic"
  region = "us-central1"
  bgp {
    asn = 64512
  }
}

resource "google_compute_router_interface" "default" {
  name     = "compute-router-interface-basic"
  region = "us-central1"
  router = google_compute_router.default.id
  subnetwork = google_compute_subnetwork.default.id
}

resource "google_compute_router_nat" "default" {
  name     = "compute-router-nat-basic"
  region = "us-central1"
  router = google_compute_router.default.id
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_vpn_gateway" "default" {
  name     = "compute-vpn-gateway-basic"
  region = "us-central1"
  network = google_compute_network.default.id
}

resource "google_compute_vpn_tunnel" "default" {
  name     = "compute-vpn-tunnel-basic"
  region = "us-central1"
  vpn_gateway = google_compute_vpn_gateway.default.id
  peer_gcp_gateway = "projects/gcp-project-id/regions/us-central1/vpnGateways/vpn-gateway-basic"
}

resource "google_compute_address" "default" {
  name   = "compute-address-basic"
  address_type = "EXTERNAL"
  region = "us-central1"
}

resource "google_compute_global_address" "default" {
  name   = "compute-global-address-basic"
  address_type = "EXTERNAL"
}

resource "google_compute_global_forwarding_rule" "default" {
  name   = "compute-global-forwarding-rule-basic"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_instance.default.self_link
  load_balancing_scheme = "INTERNAL"
}

resource "google_compute_target_https_proxy" "default" {
  name = "compute-target-https-proxy-basic"
  url_map = google_compute_url_map.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
}

resource "google_compute_ssl_certificate" "default" {
  name = "compute-ssl-certificate-basic"
  private_key = "-----BEGIN PRIVATE KEY-----\n-----END PRIVATE KEY-----\n"
  certificate = "-----BEGIN CERTIFICATE-----\n-----END CERTIFICATE-----\n"
}

resource "google_compute_target_tcp_proxy" "default" {
  name = "compute-target-tcp-proxy-basic"
  backend_service = google_compute_backend_service.default.id
}

resource "google_compute_target_ssl_proxy" "default" {
  name = "compute-target-ssl-proxy-basic"
  service = google_compute_backend_service.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
}

resource "google_compute_region_autoscaler" "default" {
  name     = "compute-region-autoscaler-basic"
  region = "us-central1"
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

resource "google_compute_region_instance_group_manager" "default" {
  name     = "compute-region-instance-group-manager-basic"
  region = "us-central1"
  version {
    name = "default"
    instance_template = google_compute_instance_template.default.self_link
  }
  base_instance_name = "instance-group-manager-basic"
  list_managed_instances_results {
    instance_state = "STABLE"
  }
}

resource "google_compute_region_instance_group_manager_list_managed_instances_results" "default" {
  instance_state = "STABLE"
}

resource "google_compute_region_backend_service" "default" {
  name     = "compute-region-backend-service-basic"
  region = "us-central1"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_region_url_map" "default" {
  name     = "compute-region-url-map-basic"
  region = "us-central1"
  host_rule {
    hosts = ["*"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name = "allpaths"
    default_service = google_compute_region_backend_service.default.id
  }
}

resource "google_compute_region_target_http_proxy" "default" {
  name     = "compute-region-target-http-proxy-basic"
  region = "us-central1"
  url_map = google_compute_region_url_map.default.id
}

resource "google_compute_region_target_https_proxy" "default" {
  name     = "compute-region-target-https-proxy-basic"
  region = "us-central1"
  url_map = google_compute_region_url_map.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
}

resource "google_compute_region_target_tcp_proxy" "default" {
  name     = "compute-region-target-tcp-proxy-basic"
  region = "us-central1"
  backend_service = google_compute_region_backend_service.default.id
}

resource "google_compute_region_target_ssl_proxy" "default" {
  name     = "compute-region-target-ssl-proxy-basic"
  region = "us-central1"
  service = google_compute_region_backend_service.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
}

resource "google_compute_region_autoscaler" "default" {
  name     = "compute-region-autoscaler-basic"
  region = "us-central1"
  target  = google_compute_region_instance_group_manager.default.id
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

resource "google_compute_region_instance_group_manager" "default" {
  name     = "compute-region-instance-group-manager-basic"
  region = "us-central1"
  version {
    name = "default"
    instance_template = google_compute_instance_template.default.self_link
  }
  base_instance_name = "instance-group-manager-basic"
  list_managed_instances_results {
    instance_state = "STABLE"
  }
}

resource "google_compute_region_instance_group_manager_list_managed_instances_results" "default" {
  instance_state = "STABLE"
}

resource "google_compute_region_backend_service" "default" {
  name     = "compute-region-backend-service-basic"
  region = "us-central1"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_region_url_map" "default" {
  name     = "compute-region-url-map-basic"
  region = "us-central1"
  host_rule {
    hosts = ["*"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name = "allpaths"
    default_service = google_compute_region_backend_service.default.id
  }
}

resource "google_compute_region_target_http_proxy" "default" {
  name     = "compute-region-target-http-proxy-basic"
  region = "us-central1"
  url_map = google_compute_region_url_map.default.id
}

resource "google_compute_region_target_https_proxy" "default" {
  name     = "compute-region-target-https-proxy-basic"
  region = "us-central1"
  url_map = google_compute_region_url_map.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
}

resource "google_compute_region_target_tcp_proxy" "default" {
  name     = "compute-region-target-tcp-proxy-basic"
  region = "us-central1"
  backend_service = google_compute_region_backend_service.default.id
}

resource "google_compute_region_target_ssl_proxy" "default" {
  name     = "compute-region-target-ssl-proxy-basic"
  region = "us-central1"
  service = google_compute_region_backend_service.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
}

resource "google_compute_region_autoscaler" "default" {
  name     = "compute-region-autoscaler-basic"
  region = "us-central1"
  target  = google_compute_region_instance_group_manager.default.id
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

resource "google_compute_region_instance_group_manager" "default" {
  name     = "compute-region-instance-group-manager-basic"
  region = "us-central1"
  version {
    name = "default"
    instance_template = google_compute_instance_template.default.self_link
  }
  base_instance_name = "instance-group-manager-basic"
  list_managed_instances_results {
    instance_state = "STABLE"
  }
}

resource "google_compute_region_instance_group_manager_list_managed_instances_results" "default" {
  instance_state = "STABLE"
}

resource "google_compute_region_backend_service" "default" {
  name     = "compute-region-backend-service-basic"
  region = "us-central1"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_region_url_map" "default" {
  name     = "compute-region-url-map-basic"
  region = "us-central1"
  host_rule {
    hosts = ["*"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name = "allpaths"
    default_service = google_compute_region_backend_service.default.id
  }
}

resource "google_compute_region_target_http_proxy" "default" {
  name     = "compute-region-target-http-proxy-basic"
  region = "us-central1"
  url_map = google_compute_region_url_map.default.id
}

resource "google_compute_region_target_https_proxy" "default" {
  name     = "compute-region-target-https-proxy-basic"
  region = "us-central1"
  url_map = google_compute_region_url_map.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
}

resource "google_compute_region_target_tcp_proxy" "default" {
  name     = "compute-region-target-tcp-proxy-basic"
  region = "us-central1"
  backend_service = google_compute_region_backend_service.default.id
}

resource "google_compute_region_target_ssl_proxy" "default" {
  name     = "compute-region-target-ssl-proxy-basic"
  region = "us-central1"
  service = google_compute_region_backend_service.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
}

resource "google_compute_region_autoscaler" "default" {
  name     = "compute-region-autoscaler-basic"
  region = "us-central1"
  target  = google_compute_region_instance_group_manager.default.id
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

resource "google_compute_region_instance_group_manager" "default" {
  name     = "compute-region-instance-group-manager-basic"
  region = "us-central1"
  version {
    name = "default"
    instance_template = google_compute_instance_template.default.self_link
  }
  base_instance_name = "instance-group-manager-basic"
  list_managed_instances_results {
    instance_state = "STABLE"
  }
}

resource "google_compute_region_instance_group_manager_list_managed_instances_results" "default" {
  instance_state = "STABLE"
}

resource "google_compute_region_backend_service" "default" {
  name     = "compute-region-backend-service-basic"
  region = "us-central1"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_region_url_map" "default" {
  name     = "compute-region-url-map-basic"
  region = "us-central1"
  host_rule {
    hosts = ["*"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name = "allpaths"
    default_service = google_compute_region_backend_service.default.id
  }
}

resource "google_compute_region_target_http_proxy" "default" {
  name     = "compute-region-target-http-proxy-basic"
  region = "us-central1"
  url_map = google_compute_region_url_map.default.id
}

resource "google_compute_region_target_https_proxy" "default" {
  name     = "compute-region-target-https-proxy-basic"
  region = "us-central1"
  url_map = google_compute_region_url_map.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
}

resource "google_compute_region_target_tcp_proxy" "default" {
  name     = "compute-region-target-tcp-proxy-basic"
  region = "us-central1"
  backend_service = google_compute_region_backend_service.default.id
}

resource "google_compute_region_target_ssl_proxy" "default" {
  name     = "compute-region-target-ssl-proxy-basic"
  region = "us-central1"
  service = google_compute_region_backend_service.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
}

resource "google_compute_region_autoscaler" "default" {
  name     = "compute-region-autoscaler-basic"
  region = "us-central1"
  target  = google_compute_region_instance_group_manager.default.id
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

resource "google_compute_region_instance_group_manager" "default" {
  name     = "compute-region-instance-group-manager-basic"
  region = "us-central1"
  version {
    name = "default"
    instance_template = google_compute_instance_template.default.self_link
  }
  base_instance_name = "instance-group-manager-basic"
  list_managed_instances_results {
    instance_state = "STABLE"
  }
}

resource "google_compute_region_instance_group_manager_list_managed_instances_results" "default" {
  instance_state = "STABLE"
}

resource "google_compute_region_backend_service" "default" {
  name     = "compute-region-backend-service-basic"
  region = "us-central1"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_region_url_map" "default" {
  name     = "compute-region-url-map-basic"
  region = "us-central1"
  host_rule {
    hosts = ["*"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name = "allpaths"
    default_service = google_compute_region_backend_service.default.id
  }
}

resource "google_compute_region_target_http_proxy" "default" {
  name     = "compute-region-target-http-proxy-basic"
  region = "us-central1"
  url_map = google_compute_region_url_map.default.id
}

resource "google_compute_region_target_https_proxy" "default" {
  name     = "compute-region-target-https-proxy-basic"
  region = "us-central1"
  url_map = google_compute_region_url_map.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
}

resource "google_compute_region_target_tcp_proxy" "default" {
  name     = "compute-region-target-tcp-proxy-basic"
  region = "us-central1"
  backend_service = google_compute_region_backend_service.default.id
}

resource "google_compute_region_target_ssl_proxy" "default" {
  name     = "compute-region-target-ssl-proxy-basic"
  region = "us-central1"
  service = google_compute_region_backend_service.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
}

resource "google_compute_region_autoscaler" "default" {
  name     = "compute-region-autoscaler-basic"
  region = "us-central1"
  target  = google_compute_region_instance_group_manager.default.id
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

resource "google_compute_region_instance_group_manager" "default" {
  name     = "compute-region-instance-group-manager-basic"
  region = "us-central1"
  version {
    name = "default"
    instance_template = google_compute_instance_template.default.self_link
  }
  base_instance_name = "instance-group-manager-basic"
  list_managed_instances_results {
    instance_state = "STABLE"
  }
}

resource "google_compute_region_instance_group_manager_list_managed_instances_results" "default" {
  instance_state = "STABLE"
}

resource "google_compute_region_backend_service" "default" {
  name     = "compute-region-backend-service-basic"
  region = "us-central1"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_region_url_map" "default" {
  name     = "compute-region-url-map-basic"
  region = "us-central1"
  host_rule {
    hosts = ["*"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name = "allpaths"
    default_service = google_compute_region_backend_service.default.id
  }
}

resource "google_compute_region_target_http_proxy" "default" {
  name     = "compute-region-target-http-proxy-basic"
  region = "us-central1"
  url_map = google_compute_region_url_map.default.id
}

resource "google_compute_region_target_https_proxy" "default" {
  name     = "compute-region-target-https-proxy-basic"
  region = "us-central1"
  url_map = google_compute_region_url_map.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
}

resource "google_compute_region_target_tcp_proxy" "default" {
  name     = "compute-region-target-tcp-proxy-basic"
  region = "us-central1"
  backend_service = google_compute_region_backend_service.default.id
}

resource "google_compute_region_target_ssl_proxy" "default" {
  name     = "compute-region-target-ssl-proxy-basic"
  region = "us-central1"
  service = google_compute_region_backend_service.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
}

resource "google_compute_region_autoscaler" "default" {
  name     = "compute-region-autoscaler-basic"
  region = "us-central1"
  target  = google_compute_region_instance_group_manager.default.id
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

resource "google_compute_region_instance_group_manager" "default" {
  name     = "compute-region-instance-group-manager-basic"
  region = "us-central1"
  version {
    name = "default"
    instance_template = google_compute_instance_template.default.self_link
  }
  base_instance_name = "instance-group-manager-basic"
  list_managed_instances_results {
    instance_state = "STABLE"
  }
}

resource "google_compute_region_instance_group_manager_list_managed_instances_results" "default" {
  instance_state =