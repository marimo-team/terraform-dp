variable "project_id" {
  description = "the project ID"
  type        = string
}

variable "region" {
  description = "the GCP region to deploy to"
  type        = string
}

variable "labels" {
  description = "additional labels to add to resources"
  type        = map(string)
  default = {
    marimo    = "true"
    terraform = "true"
  }
}
