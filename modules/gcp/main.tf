locals {
  roles = [
    "roles/run.developer",                # Manage cloud run services
    "roles/run.invoker",                  # Invoke cloud run services
    "roles/secretmanager.secretAccessor", # Access env secrets
    "roles/secretmanager.admin",          # Create and manage secrets
    "roles/artifactregistry.writer",      # Push to docker registry in data plane
    "roles/iam.serviceAccountUser",       # Impersonate service accounts
    "roles/iam.serviceAccountCreator",    # Create service accounts
  ]

  activate_apis = [
    # Artifact Registry
    "artifactregistry.googleapis.com",
    # Identity and Access Management (IAM) API
    "iam.googleapis.com",
    # Secret Manager
    "secretmanager.googleapis.com",
    # Cloud Run
    "run.googleapis.com",
    "container.googleapis.com",
    # Cloud Storage
    "storage-api.googleapis.com",
  ]
}

# Activate APIs
resource "google_project_service" "project_services" {
  for_each                   = toset(local.activate_apis)
  project                    = var.project_id
  service                    = each.value
  disable_on_destroy         = false
  disable_dependent_services = false
}

# Service account
resource "google_service_account" "marimo_cp" {
  depends_on   = [google_project_service.project_services]
  project      = var.project_id
  account_id   = "marimo-cp"
  display_name = "Marimo Control Plane Service Account"
  description  = "Service account for the control plane to access the data plane"
}

# Service account credentials
resource "google_service_account_key" "marimo_cp" {
  depends_on         = [google_project_service.project_services]
  service_account_id = google_service_account.marimo_cp.name
}

# Add roles to service account
resource "google_project_iam_member" "marimo_cp" {
  depends_on = [google_project_service.project_services]
  project    = var.project_id
  for_each   = toset(local.roles)
  role       = each.value
  member     = "serviceAccount:${google_service_account.marimo_cp.email}"
}

# Docker Registry for Marimo Apps in Data Plane
resource "google_artifact_registry_repository" "marimo_apps_docker" {
  depends_on = [google_project_service.project_services]
  # Beta provider is required for cleanup_policies
  # If you don't want to use cleanup_policies, you can use the google provider
  provider      = google-beta
  location      = var.region
  repository_id = "marimo-apps"
  description   = "Marimo Apps Docker Registry"
  format        = "DOCKER"
  project       = var.project_id

  labels = var.labels

  cleanup_policies {
    id     = "keep-minimum-versions"
    action = "KEEP"
    most_recent_versions {
      keep_count = 2
    }
  }
}

# GCS Buckets for the data plane
module "gcs_buckets" {
  depends_on = [google_project_service.project_services]
  # https://registry.terraform.io/modules/terraform-google-modules/cloud-storage/google/latest
  source     = "terraform-google-modules/cloud-storage/google"
  version    = "~> 5.0"
  project_id = var.project_id
  location   = var.region
  names = [
    # App Code Bucket - Stores the code for all Marimo apps, before deployment
    "app-code-bucket",
    # App Screenshots Bucket - Stores the screenshots for all Marimo apps
    "app-screenshots-bucket",
  ]
  # Buckets are globally unique in GCP
  prefix          = var.project_id
  set_admin_roles = true
  admins          = ["serviceAccount:${google_service_account.marimo_cp.email}"]
  versioning      = {}
  labels          = var.labels
}
