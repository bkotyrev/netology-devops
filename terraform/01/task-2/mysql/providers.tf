terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "4.5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }
  }
  required_version = "~>1.12.0"
}

provider "docker" {
  host = var.docker_host
}
