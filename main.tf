provider "google" {
    project = "playground-s-11-0d36a919"
    region = "us-central1-a"
}

resource "google_storage_bucket" "static-site" {
  name          = "naztest8789065536633773700"
  location      = "US-CENTRAL1"
}