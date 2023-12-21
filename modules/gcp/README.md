## Requirements

| Name                                                                           | Version        |
| ------------------------------------------------------------------------------ | -------------- |
| <a name="requirement_google"></a> [google](#requirement_google)                | >= 3.53, < 6.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement_google-beta) | >= 3.53, < 6.0 |

## Providers

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="provider_google"></a> [google](#provider_google)                | 5.10.0  |
| <a name="provider_google-beta"></a> [google-beta](#provider_google-beta) | 5.10.0  |

## Modules

| Name                                                                 | Source                                        | Version |
| -------------------------------------------------------------------- | --------------------------------------------- | ------- |
| <a name="module_gcs_buckets"></a> [gcs_buckets](#module_gcs_buckets) | terraform-google-modules/cloud-storage/google | ~> 5.0  |

## Resources

| Name                                                                                                                                                                                          | Type     |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [google-beta_google_artifact_registry_repository.marimo_apps_docker](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_artifact_registry_repository) | resource |
| [google_project_iam_member.marimo_cp](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member)                                                      | resource |
| [google_project_service.project_services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service)                                                     | resource |
| [google_service_account.marimo_cp](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account)                                                            | resource |
| [google_service_account_key.marimo_cp](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key)                                                    | resource |

## Inputs

| Name                                                            | Description                           | Type          | Default                                                         | Required |
| --------------------------------------------------------------- | ------------------------------------- | ------------- | --------------------------------------------------------------- | :------: |
| <a name="input_labels"></a> [labels](#input_labels)             | additional labels to add to resources | `map(string)` | <pre>{<br> "marimo": "true",<br> "terraform": "true"<br>}</pre> |    no    |
| <a name="input_project_id"></a> [project_id](#input_project_id) | the project ID                        | `string`      | n/a                                                             |   yes    |
| <a name="input_region"></a> [region](#input_region)             | the GCP region to deploy to           | `string`      | n/a                                                             |   yes    |

## Outputs

| Name                                                                                                                       | Description                                   |
| -------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| <a name="output_marimo_artifact_registry"></a> [marimo_artifact_registry](#output_marimo_artifact_registry)                | the artifact registry for the data plane      |
| <a name="output_marimo_cp_service_account"></a> [marimo_cp_service_account](#output_marimo_cp_service_account)             | the service account for the control plane     |
| <a name="output_marimo_cp_service_account_key"></a> [marimo_cp_service_account_key](#output_marimo_cp_service_account_key) | the service account key for the control plane |
