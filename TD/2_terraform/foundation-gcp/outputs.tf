output "vpc_name" {
 value = google_compute_network.vpc.name
}
output "vm_ip" {
 value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}
output "db_private_ip" {
 value = google_sql_database_instance.db.private_ip_address
}
