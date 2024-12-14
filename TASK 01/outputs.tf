# Captures key outputs from the infrastructure.

# Name of the VPC
output "vpc_name" {
  description = "The name of the created VPC"
  value       = google_compute_network.vpc_network.name
}

# Name of the general-purpose subnet
output "general_subnet" {
  description = "The name of the general-purpose subnet"
  value       = google_compute_subnetwork.subnet_general.name
}

# Name of the CPU-intensive subnet
output "cpu_intensive_subnet" {
  description = "The name of the CPU-intensive subnet"
  value       = google_compute_subnetwork.subnet_cpu_intensive.name
}

# Endpoint of the GKE cluster
output "cluster_endpoint" {
  description = "The endpoint of the GKE cluster"
  value       = google_container_cluster.primary.endpoint
}
