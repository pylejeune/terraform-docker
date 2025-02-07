terraform {

  backend "remote" {
    hostname     = "app.terraform.io"  # HCP Terraform utilise ce hostname
    organization = "pylejeune"  # Remplacez par le nom de votre organisation HCP

    workspaces {
      name = "terraform-docker"  # Remplacez par le nom de votre workspace
    }
  }

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
  required_version = "~> 1.7"
}
