# Defines all input variables with default values and descriptions.

# GCP project ID
variable "project_id" {
  description = "The GCP project ID to deploy resources into"
  type        = string
}

# Region for GCP resources
variable "region" {
  description = "The GCP region to deploy resources in"
  type        = string
  default     = "us-central1"
}

# GCS bucket for Terraform state
variable "state_bucket_name" {
  description = "The name of the GCS bucket to store Terraform state"
  type        = string
}

# CIDR block for the general-purpose subnet
variable "general_subnet_cidr" {
  description = "CIDR range for the general-purpose subnet"
  type        = string
  default     = "10.0.0.0/24"
}

# CIDR block for the CPU-intensive subnet
variable "cpu_intensive_subnet_cidr" {
  description = "CIDR range for the CPU-intensive subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# General-purpose node pool configuration
variable "general_pool_node_count" {
  description = "Number of nodes in the general-purpose node pool"
  type        = number
  default     = 2
}

variable "general_pool_machine_type" {
  description = "Machine type for general-purpose workloads"
  type        = string
  default     = "e2-standard-4"
}

# CPU-intensive node pool configuration
variable "cpu_intensive_pool_node_count" {
  description = "Number of nodes in the CPU-intensive node pool"
  type        = number
  default     = 2
}

variable "cpu_intensive_pool_machine_type" {
  description = "Machine type for CPU-intensive workloads"
  type        = string
  default     = "n2-highcpu-8"
}
