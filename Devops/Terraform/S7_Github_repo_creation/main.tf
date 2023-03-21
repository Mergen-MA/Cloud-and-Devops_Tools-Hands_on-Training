terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "5.18.0"
    }
  }
}

provider "github" {
  token = var.token
}


resource "github_repository" "created-by-terraform" {
  name = "created-by-terraform"
  description = "My first repo through terraform"
  visibility = "public"
  
}