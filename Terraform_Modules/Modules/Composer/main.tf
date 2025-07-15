provider "google" {
  project     = var.project_id_value
  region      = "us-central1"
  
}

resource "google_composer_environment" "test_from_tf" {
  name   = "example-composer-env-tf"
  region = "us-central1"
 config {
    software_config {
      image_version = "composer-2.10.2-airflow-2.10.2"
    }

    node_config {
      service_account = "751345403071-compute@developer.gserviceaccount.com"
    }

  }
}
