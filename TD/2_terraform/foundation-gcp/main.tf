resource "google_compute_network" "vpc" {

  name                    = "td-vpc"

  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "subnet" {

  name          = "td-subnet"

  ip_cidr_range = "10.0.1.0/24"

  region        = "europe-west1"

  network       = google_compute_network.vpc.id

}

resource "google_compute_instance" "vm" {

  name         = "td-vm"

  machine_type = "e2-micro"

  zone         = "europe-west1-b"

  boot_disk {

    initialize_params {

      image = "debian-cloud/debian-12"

    }

  }

  network_interface {

    subnetwork = google_compute_subnetwork.subnet.id

    access_config {}

  }

}
 
 
