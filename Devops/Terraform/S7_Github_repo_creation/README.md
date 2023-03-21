# Hands-on Terraform-06 : Github Repository Creation with Terraform:

Purpose of the this hands-on training is to give students the knowledge of basic operations in Terraform.

## Learning Outcomes

  required_providers {
    github = {
      source = "integrations/github"
      version = "5.18.0"
    }
  }
}

provider "github" {
    token = var.token
  # Configuration options
}

variable "token" {
    type = string
    default = "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"
  
}
resource "github_repository" "created-by-terraform" {
  name        = "created-by-terraform"
  description = "My first tf repo"

  visibility = "public"

}
