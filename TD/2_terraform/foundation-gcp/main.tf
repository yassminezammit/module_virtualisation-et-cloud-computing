# VPC
resource "google_compute_network" "vpc" {
 name                    = "td-vpc"
 auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "subnet" {
 name          = "td-subnet"
 ip_cidr_range = "10.0.1.0/24"
 region        = var.region
 network       = google_compute_network.vpc.id
}
# VM 
resource "google_compute_instance" "vm" {
 name         = "td-vm"
 machine_type = var.machine_type
 zone         = var.zone
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
# Base de données (dans le VPC) 
resource "google_compute_global_address" "sql_range" {
 name          = "td-sql-range"
 purpose       = "VPC_PEERING"
 address_type  = "INTERNAL"
 prefix_length = 16
 network       = google_compute_network.vpc.id
}
resource "google_service_networking_connection" "peering" {
 network                 = google_compute_network.vpc.id
 service                 = "servicenetworking.googleapis.com"
 reserved_peering_ranges = [google_compute_global_address.sql_range.name]
}
resource "google_sql_database_instance" "db" {
 name                = "td-db"
 database_version    = "POSTGRES_15"
 region              = var.region
 deletion_protection = false
 settings {
   tier = "db-f1-micro"
   ip_configuration {
     ipv4_enabled    = false
     private_network = google_compute_network.vpc.id
   }
 }
 depends_on = [google_service_networking_connection.peering]
}
