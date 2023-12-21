output "marimo_cp_service_account" {
  description = "the service account for the control plane"
  value       = google_service_account.marimo_cp.email
}

output "marimo_cp_service_account_key" {
  description = "the service account key for the control plane"
  sensitive   = true
  value       = google_service_account_key.marimo_cp.private_key
}

output "marimo_artifact_registry" {
  description = "the artifact registry for the data plane"
  value       = google_artifact_registry_repository.marimo_apps_docker.name
}
