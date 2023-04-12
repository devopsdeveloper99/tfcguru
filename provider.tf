terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.59.0"
    }
  }
}

provider "google" {
  project = "playground-s-11-eb7ce832"
  region  = "us-central1"
  zone    = "us-central1-c"
}