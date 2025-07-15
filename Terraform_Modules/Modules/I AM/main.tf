provider "google" {
  project     = var.project_id_value
  region      = "us-central1"
  
}

#https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam_custom_role
#create a custom role with display as My Custom Role

resource "google_project_iam_custom_role" "my-custom-role" {
  role_id     = "myCustomRoletf"
  title       = "My Custom Role"
  description = "A description"
  permissions = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]
}

#https://cloud.google.com/billing/docs/reference/rest/v1/Policy#Binding
#https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_binding
#Adding the role to the member

resource "google_project_iam_binding" "project_iam_binding" {
  project = var.project_id_value
  role    = google_project_iam_custom_role.my-custom-role.name

  members = [
    "serviceAccount:jenkins-123@cts13-yemireddyc.iam.gserviceaccount.com",
  ]
}

#https://github.com/terraform-google-modules/terraform-google-iam/blob/main/modules/custom_role_iam/main.tf

data "google_iam_role" "base" {
  for_each = toset(var.base_roles)
  name     = each.value
}

locals {
  base_permissions = distinct(flatten([
    for role in data.google_iam_role.base : role.included_permissions
  ]))

  effective_permissions = distinct([
    for perm in concat(local.base_permissions, var.additional_permissions) : perm if !(contains(var.excluded_permissions, perm))
  ])
}


resource "google_project_iam_custom_role" "custom-role-1" {
  role_id     = var.role_id
  title       = var.title
  description = var.description
  project     = var.project_id_value
  permissions = local.effective_permissions
}
