terraform {
 required_providers {
   google = {
     source = "hashicorp/google"
   }
 }
}
provider "google" {
 project      = "polytech-dijon"
 region       = "europe-west1"
 access_token = "patate"
}
