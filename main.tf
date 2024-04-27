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
  zone        = "us-central1"          # Updated zone
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
  region             = "us-central1"
}

#resource "google_compute_network" "custom-vpc-tf" {
  #name = "custom-vpc-tf"
 #auto_create_subnetworks = false
#}


resource "google_compute_instance" "vm_instance" {
  name         = "malgus-instance"
  machine_type = "n2-standard-4"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.sub-sg.id
    access_config {}
  }
  metadata_startup_script = "echo 'Hello, world! This is a startup script.' > /var/www/html/index.html"
}




output "auto" {
  value = google_compute_network.auto-vpc-tf.id
}

#output "custom" {
#  value = google_compute_network.custom-vpc-tf.id
#}


output "vm_access_link" {
  value = "http://${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}"
}