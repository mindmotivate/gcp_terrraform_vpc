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
  zone        = "us-east1"          # Updated zone
  credentials = "theta-style-416117-95ff7de18b6e.json"  # Updated credentials file
}

resource "google_storage_bucket" "malgusclan_bucket" {
  name          = "malgusclan_bucket"
  location      = "us-east1"
  force_destroy = true
}

resource "google_compute_network" "malgusclan_vpc" {
  name                  = "malgusclan_vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "malgusclan_subnetwork" {
  name               = "malgusclan_subnetwork"
  network            = google_compute_network.malgusclan_vpc.id
  ip_cidr_range      = "10.136.1.0/24"
  region             = "us-central1"
}

#resource "google_compute_network" "custom-vpc-tf" {
#  name = "custom-vpc-tf"
#  auto_create_subnetworks = false
#}

output "auto" {
  value = google_compute_network.malgusclan_vpc.id
}

#output "custom" {
#  value = google_compute_network.custom-vpc-tf.id
#}
