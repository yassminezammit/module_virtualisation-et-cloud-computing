variable "region" {
 description = "Région GCP"
 type        = string
 default     = "europe-west1"
}
variable "zone" {
 description = "Zone de la VM"
 type        = string
 default     = "europe-west1-b"
}
variable "machine_type" {
 description = "Taille de la VM"
 type        = string
 default     = "e2-micro"
}
