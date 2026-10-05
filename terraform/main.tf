terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# -------------------------
# Frontend Docker Image
# -------------------------

resource "docker_image" "frontend" {
  name = "git-iac-frontend:${var.environment}"

  build {
    context    = "../docker/frontend"
    dockerfile = "Dockerfile"
  }
}

# -------------------------
# Backend Docker Image
# -------------------------

resource "docker_image" "backend" {
  name = "git-iac-backend:${var.environment}"

  build {
    context    = "../docker/backend"
    dockerfile = "Dockerfile"
  }
}

# -------------------------
# Frontend Container
# -------------------------

resource "docker_container" "frontend" {
  name  = "git-iac-frontend-${var.environment}"
  image = docker_image.frontend.image_id

  ports {
    internal = 80
    external = var.frontend_port
  }
}

# -------------------------
# Backend Container
# -------------------------

resource "docker_container" "backend" {
  name  = "git-iac-backend-${var.environment}"
  image = docker_image.backend.image_id

  ports {
    internal = 5000
    external = var.backend_port
  }
}