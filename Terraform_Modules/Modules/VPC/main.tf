provider "google" {
  project     = var.project_id_value
  region      = "us-central1"
  
}

# variable "region1" {
#   default = "asia-east2"
# }
# variable "region2" {
#   default = "asia-northeast1"
# }

# #https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network

# # resource "google_compute_network" "vpc_network" {
# #   project                 = var.project_id_value
# #   name                    = "first-custom-vpc-network"
# #   auto_create_subnetworks = false
# # }

# # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork


# resource "google_compute_network" "private_vpc" {
#   project                 = var.project_id_value
#   name                    = "private-vpc-1-tf"
#   auto_create_subnetworks = false
# }

# resource "google_compute_subnetwork" "subnet1" {
#   name          = "private-subnet-1"
#   ip_cidr_range = "10.10.0.0/24"
#   region        = var.region1
#   network       = google_compute_network.private_vpc.id
#   private_ip_google_access = true
# }

# resource "google_compute_subnetwork" "subnet2" {
#   name          = "private-subnet-2"
#   ip_cidr_range = "10.20.0.0/24"
#   region        = var.region2
#   network       = google_compute_network.private_vpc.id
#   private_ip_google_access = true
# }

# # Allow ICMP (ping) within VPC
# resource "google_compute_firewall" "allow-internal-icmp" {
#   name    = "allow-internal-icmp"
#   network = google_compute_network.private_vpc.name

#   direction = "INGRESS"
#   priority  = 100

#   source_ranges = ["10.10.0.0/24", "10.20.0.0/24"]

#   allow {
#     protocol = "icmp" # This should be 'allow' not 'allows'
#   } 

#   description = "Allow ICMP (ping) within VPC subnets"
# }





# Create VPC
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Create Subnets
resource "google_compute_subnetwork" "subnets" {
  count         = length(var.subnets)
  name          = var.subnets[count.index].name
  ip_cidr_range = var.subnets[count.index].cidr_block
  region        = var.subnets[count.index].region
  network       = google_compute_network.vpc.name
}


