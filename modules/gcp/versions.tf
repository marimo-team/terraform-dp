terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.53, < 6.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 3.53, < 6.0"
    }
  }
}
