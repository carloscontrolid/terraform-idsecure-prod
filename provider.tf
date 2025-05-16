# provider.tf
terraform {
  cloud {
    organization = "ControliD"

    workspaces {
      name = "terraform-idsecure-prod"
    }
  }
}

provider "aws" {
  region     = var.AWS_region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}