# Configures remote backend storage for the Terraform state.

terraform {
  backend "gcs" {
    bucket = var.state_bucket_name
    prefix = "terraform/state"
  }
}
