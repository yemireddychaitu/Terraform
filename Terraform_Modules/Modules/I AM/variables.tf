variable "project_id_value" {
  description = "value for the project"
}


variable "role_id" {
  description = "The ID of the custom role"
  type        = string
}

variable "title" {
  description = "Title of the custom role"
  type        = string
}

variable "description" {
  description = "Description for the custom role"
  type        = string
}

variable "base_roles" {
  description = "List of base roles to derive permissions from"
  type        = list(string)
  default     = []
}

variable "additional_permissions" {
  description = "Additional IAM permissions to include"
  type        = list(string)
  default     = []
}

variable "excluded_permissions" {
  description = "Permissions to exclude"
  type        = list(string)
  default     = []
}
