# This file defines the core Terraform resources, such as the VPC, subnets, GKE cluster, and node pools.

# Define a VPC
resource "google_compute_network" "vpc_network" {
  name                    = "custom-vpc"
  auto_create_subnetworks = false  # Disables default subnet creation for better control
}

# Define a general-purpose subnet
resource "google_compute_subnetwork" "subnet_general" {
  name          = "general-subnet"
  ip_cidr_range = var.general_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

# Define a CPU-intensive workload subnet
resource "google_compute_subnetwork" "subnet_cpu_intensive" {
  name          = "cpu-intensive-subnet"
  ip_cidr_range = var.cpu_intensive_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

# Create the GKE cluster with no default node pool
resource "google_container_cluster" "primary" {
  name     = "gke-cluster"
  location = var.region

  networking_mode = "VPC_NATIVE"  # Enables VPC-native routing for better integration
  network         = google_compute_network.vpc_network.id
  subnetwork      = google_compute_subnetwork.subnet_general.id

  remove_default_node_pool = true  # Remove the default node pool
  initial_node_count       = 1

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }
}

# General-purpose node pool
resource "google_container_node_pool" "general" {
  name       = "general-node-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.region
  node_count = var.general_pool_node_count

  node_config {
    machine_type = var.general_pool_machine_type
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

# CPU-intensive node pool
resource "google_container_node_pool" "cpu_intensive" {
  name       = "cpu-intensive-node-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.region
  node_count = var.cpu_intensive_pool_node_count

  node_config {
    machine_type = var.cpu_intensive_pool_machine_type
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
