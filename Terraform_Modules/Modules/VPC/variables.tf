variable "project_id_value" {
    description = "value for the project"
}

variable "vpc_name" {
    description = "value for the project"
}

# variable "subnets" {
#     description = "value for the project"
# }

# variable "region" {
#     description = "value for the project"
# }

variable "subnets" {
  description = "List of subnets to create"
  type = list(object({
    name       = string
    cidr_block = string
    region     = string
  }))
}

# variable "id" {
#     description = "value for the project"
# }

# variable "id" {
#     description = "value for the project"
# }

# variable "id" {
#     description = "value for the project"
# }

# variable "id" {
#     description = "value for the project"
# }

# variable "id" {
#     description = "value for the project"
# }   
