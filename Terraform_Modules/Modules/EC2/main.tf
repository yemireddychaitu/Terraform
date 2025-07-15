provider "google" {
  project     = var.project_id_value
  region      = "us-central1"
  
}

# Create a compute instance
# resource "google_compute_instance" "first_compute_tf" {
#   name         = var.name_of_instance
#   machine_type = var.machine_type_value            # You can choose other machine types

#   # Specify the zone within the region
#   zone         = var.zone_value

#   # Define the boot disk
#   boot_disk {
#     initialize_params {
#       image = var.image_value  # Use Debian 10 image
#     }
#   }

#   # Set network interface with default VPC and external IP
#   network_interface {
#     network       = "default"
#     access_config {}                   # Allocate ephemeral external IP
#   }

#   # Optional: Add tags or metadata
#   tags = ["web", "dev"]
# }

resource "google_compute_instance" "default" {
  name         = var.name_of_instance
  machine_type = var.machine_type_value
  zone         = var.zone_value
  project      = var.project_id_value

  boot_disk {
    initialize_params {
      image = var.image_value
    }
  }

  network_interface {
    network    = var.network_value
    subnetwork = var.subnet_value
    access_config {} # Adds external IP
  }


}



