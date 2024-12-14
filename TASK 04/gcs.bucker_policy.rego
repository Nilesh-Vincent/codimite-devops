package main

# Rule to ensure all GCS buckets have encryption enabled.
deny[msg] {
  input.resource.type == "google_storage_bucket"
  not input.resource.values.encryption
  msg := sprintf("Bucket '%s' must have encryption enabled.", [input.resource.name])
}

# Rule to ensure all GCS buckets are restricted to specific projects.
deny[msg] {
  input.resource.type == "google_storage_bucket"
  allowed_projects := ["project-12345", "project-67890"] # Add allowed project IDs here
  not contains(allowed_projects, input.resource.values.project)
  msg := sprintf("Bucket '%s' must belong to one of the allowed projects: %s.", [input.resource.name, allowed_projects])
}