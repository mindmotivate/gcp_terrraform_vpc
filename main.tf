terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.25.0"
    }
  }
}

provider "google" {
  project     = "theta-style-416117"   # Updated project name
  region      = "asia-northeast1"        # Updated region
  zone        = "us-central1-a"          # Updated zone
  credentials = "theta-style-416117-95ff7de18b6e.json"              # Updated credentials file
}

resource "google_storage_bucket" "bucket1" {
  name          = "malgus_clan_bucket"
  location      = "us-central1"
  force_destroy = true
}

resource "google_compute_network" "auto-vpc-tf" {
  name                  = "auto-vpc-tf"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "sub-sg" {
  name               = "sub-sg"
  network            = google_compute_network.auto-vpc-tf.id
  ip_cidr_range      = "10.72.1.0/24"
  region             = "asia-northeast1"
}

#resource "google_compute_network" "custom-vpc-tf" {
  #name = "custom-vpc-tf"
 #auto_create_subnetworks = false
#}

output "auto" {
  value = google_compute_network.auto-vpc-tf.id
}

#output "custom" {
#  value = google_compute_network.custom-vpc-tf.id
#}