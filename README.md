# terraform-dp

Terraform modules to configure your marimo data plane.

## Usage - GCP

1. Create a project in GCP
2. Add the following to your terraform configuration, or copy `modules/gcp/main.tf` to your project.

```hcl
module "marimo_dp" {
  source = "github.com/marimo-team/terraform-dp//modules/gcp?ref=v0.1.0"

  project_id = "my-project"
  region     = "us-central1"
}
```
