provider "google" {
  credentials = file("/home/senthilmurugan_c/terraform-sa/service-account.json")
  project     = var.project_id
  region      = var.region
}
