provider "google" {
  project     = "cts13-yemireddyc"
  region      = "us-central1"
  credentials = file("key.json")
  
}

# module "ec2_instance" {
#   source = "./module/ec2"
#   project_id_value="cts13-yemireddyc"
#   name_of_instance="sample-instance-from-tf"
#   machine_type_value="e2-medium"
#   zone_value="us-central1-a"
#   image_value="debian-12-bookworm-v20250415"
# }

#creating the composer

module "composer" {
  source = "./module/composer"
  project_id_value="cts13-yemireddyc"
}

module "IAM"{
  source = "./module/IAM"
  project_id_value="cts13-yemireddyc"
  role_id    = "customDataOpsRole"
  title      = "Custom DataOps Role"
  description = "Combines storage admin and viewer permissions with some custom logic"

  base_roles = [
    "roles/logging.viewer",
    "roles/compute.viewer"
  ]

  additional_permissions = [
    "compute.instances.start",  
    "compute.instances.stop"
  ]

  excluded_permissions = [
    "compute.regionOperations.get",
    "resourcemanager.projects.list"

  ]
}

# module "VPC" {
#   source = "./module/VPC"
#   project_id_value="cts13-yemireddyc"
  
  
# }

module "VPC"{
  source = "./module/VPC"
  project_id_value="cts13-yemireddyc"
  vpc_name="my-custom-vpc-1"
  subnets = [
    {
      name       = "subnet-1"
      cidr_block = "10.0.1.0/24"
      region     = "asia-east2" 
    },
    {
      name       = "subnet-2"
      cidr_block = "10.0.2.0/24"
      region     = "asia-northeast1"
    }
  ]
}

# module "ec2-1" {
#   source = "./module/ec2"
#   project_id_value="cts13-yemireddyc"
#   name_of_instance="sample-instance-from-tf-1"
#   machine_type_value="e2-medium"
#   zone_value="asia-east2-a"
#   image_value="debian-12-bookworm-v20250415"
#   network_value=module.VPC.network_name
#   subnet_value="subnet-1" 

# }

# module "ec2-2" {
#   source = "./module/ec2"
#   project_id_value="cts13-yemireddyc"
#   name_of_instance="sample-instance-from-tf-2"
#   machine_type_value="e2-medium"
#   zone_value="asia-northeast1-a"
#   image_value="debian-12-bookworm-v20250415"
#   network_value=module.VPC.network_name
#   subnet_value="subnet-2" 

# }

resource "google_compute_instance" "vm_1" {
  name         = "sample-instance-from-tf-1"
  machine_type = "e2-medium"
  zone         = "asia-east2-a"

  boot_disk {
    initialize_params {
      image = "debian-12-bookworm-v20250415"
    }
  }

  network_interface {
    network = "my-custom-vpc-1"
    subnetwork = "subnet-1"
    access_config {}
  }

  # You can add other fields later after import
}



