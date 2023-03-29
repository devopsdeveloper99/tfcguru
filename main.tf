provider "google" {
    project = "playground-s-11-e800175f"
    region = "us-central1-a"
}

# resource "google_storage_bucket" "static-site" {
#   name          = "naztest8789065536633773700"
#   location      = "US-CENTRAL1"
# }

resource "google_service_account" "default" {
  account_id   = "116484940409849554682"
  display_name = "Compute Engine default service account"
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}