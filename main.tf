terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.59.0"
    }
  }
}

provider "google" {
  project = "playground-s-11-e800175f"
  region  = "us-central1"
  zone    = "us-central1-c"
}

#Create Bucket
#Upload index.zip
#deploy function
#policy binding

resource "google_storage_bucket" "fun_bucket" {
  name = "fun_bucket_tf"
}

resource "google_storage_bucket_object" "srccode" {
  name = "index.zip"
  bucket = google_storage_bucket.fun_bucket.name
  source = "index.zip"
}

resource "google_cloudfunctions_function" "fun_from_tf" {
  name = "fun-from-tf"
  runtime = "nodejs14"
  description = "This is my first function from terraform script."

  available_memory_mb = 128
  source_archive_bucket = google_storage_bucket.fun_bucket.name
  source_archive_object = google_storage_bucket_object.srccode.name

  trigger_http = true
  entry_point = "helloWorldtf"

}

resource "google_cloudfunctions_function_iam_member" "allowaccess" {
  region = google_cloudfunctions_function.fun_from_tf.region
  cloud_function = google_cloudfunctions_function.fun_from_tf.name

  role = "roles/cloudfunctions.invoker"
  member = "allUsers" 

}