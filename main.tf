
# resource "google_storage_bucket" "fun_bucket99991111" {
#   name = "fun_bucket_tf"
#   location      = "US-CENTRAL1"
# }

# resource "google_storage_bucket_object" "srccode" {
#   name = "index.zip"
#   bucket = google_storage_bucket.fun_bucket99991111.name
#   source = "index.zip"
# }

# resource "google_cloudfunctions_function" "fun_from_tf" {
#   name = "fun-from-tf"
#   runtime = "nodejs14"
#   description = "This is my first function from terraform script."

#   available_memory_mb = 128
#   source_archive_bucket = google_storage_bucket.fun_bucket99991111.name
#   source_archive_object = google_storage_bucket_object.srccode.name

#   trigger_http = true
#   entry_point = "helloWorldtf"

# }

# resource "google_cloudfunctions_function_iam_member" "allowaccess" {
#   region = google_cloudfunctions_function.fun_from_tf.region
#   cloud_function = google_cloudfunctions_function.fun_from_tf.name

#   role = "roles/cloudfunctions.invoker"
#   member = "allUsers" 

# }

resource "google_storage_bucket" "static" {
 name          = "nazmu898989"
 location      = "us-central1"
 storage_class = "STANDARD"

 uniform_bucket_level_access = true
}