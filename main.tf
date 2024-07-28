
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

resource "google_pubsub_topic" "default" {
  name     = "pubsub-topic-basic"
  project  = "abc"
  location = "us-central1"
}

resource "google_pubsub_subscription" "default" {
  name     = "pubsub-subscription-basic"
  topic    = google_pubsub_topic.default.name
  project  = "abc"
  location = "us-central1"
}

resource "google_kms_crypto_key" "default" {
  name     = "kms-crypto-key-basic"
  purpose  = "ENCRYPT_DECRYPT"
  rotation_period = "86400s"
  version_template {
    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
  }
  key_ring = google_kms_key_ring.default.id
}

resource "google_kms_key_ring" "default" {
  name     = "kms-key-ring-basic"
  location = "us-central1"
  project  = "abc"
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
  network = "default"
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

resource "google_dns_managed_zone" "default" {
  name     = "dns-managed-zone-basic"
  dns_name = "example.com."
  project  = "abc"
  description = "DNS zone for example.com"
}

resource "google_dns_record_set" "default" {
  name    = "www"
  type    = "A"
  ttl     = 300
  managed_zone = google_dns_managed_zone.default.name
  project  = "abc"
  rrdatas = ["1.2.3.4"]
}

resource "google_compute_firewall" "default" {
  name    = "firewall-basic"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "default" {
  name    = "external-ip-basic"
  address_type = "EXTERNAL"
  project  = "abc"
  region  = "us-central1"
}

resource "google_compute_forwarding_rule" "default" {
  name    = "forwarding-rule-basic"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_instance.default.self_link
  load_balancing_scheme = "INTERNAL"
  network = "default"
  region  = "us-central1"
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
  region  = "us-central1"
  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_backend_service" "default" {
  name    = "backend-service-basic"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 15
  health_checks = [google_compute_health_check.default.id]
  port = 80
  load_balancing_scheme = "INTERNAL"
  region  = "us-central1"
}

resource "google_compute_url_map" "default" {
  name    = "url-map-basic"
  default_service = google_compute_backend_service.default.id
  host_rule {
    hosts = ["example.com"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name = "allpaths"
    default_service = google_compute_backend_service.default.id
  }
  region  = "us-central1"
}

resource "google_compute_target_http_proxy" "default" {
  name    = "target-http-proxy-basic"
  url_map = google_compute_url_map.default.id
  region  = "us-central1"
}

resource "google_compute_global_forwarding_rule" "default" {
  name    = "global-forwarding-rule-basic"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_target_http_proxy.default.id
  load_balancing_scheme = "INTERNAL"
  network = "default"
}

resource "google_compute_autoscaler" "default" {
  name    = "autoscaler-basic"
  project = "abc"
  zone    = "us-central1-a"
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
  project = "abc"
  zone    = "us-central1-a"
  base_instance_name = "autoscaler-instance-basic"
  version {
    name = "autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_instance_template" "default" {
  name_prefix  = "autoscaler-template-basic"
  machine_type = "e2-medium"
  network_interface {
    network = "default"
  }
  disk {
    source_image = "centos-cloud/centos-7"
    auto_delete  = true
    boot         = true
    type         = "PERSISTENT"
  }
  project = "abc"
  zone    = "us-central1-a"
}

resource "google_compute_region_autoscaler" "default" {
  name    = "region-autoscaler-basic"
  project = "abc"
  region  = "us-central1"
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
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-basic"
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  name    = "region-instance-group-manager-basic"
  project = "abc"
  region  = "us-central1"
  base_instance_name = "region-autoscaler-instance-basic"
  version {
    name = "region-autoscaler-version-