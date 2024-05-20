# Terraform AWS Template

Terraform template to bootstrap a baseline account on AWS.

<!-- BEGIN_TEMPLATE_DOCUMENTATION -->
### Features
| Feature | Description | File |
|---------|-------------|----------|
| VPC | AWS VPC in the default region | `vpc.tf` |
| Subnets | Public and private subnets across 3 AZ's in the default region | `vpc.tf` |
| NAT Gateway | NAT Gateway with static IP in the default region | `vpc.tf` |
| Budgets | Budget alert, defaults to 100 USD | `budget.tf` |
| IAM | Assigns defined roles to IAM users across 3 levels `admin`, `dev` and `basic` | `iam.tf` |
| CI/CD | GitHub Actions to `lint`, `plan`, and `apply` to AWS | `.github/workflows/terraform-apply.yaml`, `.github/workflows/terraform-plan.yaml` |

## Usage
> **DO NOT FORK** this is meant to be used from **[Use this template](https://github.com/braveokafor/terraform-aws-template/generate)** feature.

1. Click on **[Use this template](https://github.com/braveokafor/terraform-aws-template/generate)**
3. Give a name to your repo
3. Wait until the first run of CI finishes  
   (Github Actions will process the template and commit to your new repo)
4. Clone your new repo.
5. Update `provider.tf` with your `backend` info.
4. If you don't want CI/CD (GitHub Actions), delete `.github/workflows/terraform-apply.yaml` and `.github/workflows/terraform-plan.yaml`  
5. If you want CI/CD (GitHub Actions):  
  On the new repository `settings->secrets` add your `AWS_REGION`, `AWS_ROLE_TO_ASSUME` and `TERRAFORM_PLAN_BUCKET` (to store plan files).  
  To `plan`, create a `feature branch` and raise a `PR` to `main`.  
  To `apply`, merge the `PR` into `main` (note the `apply` job runs against the `feature branch`).  
  A terraform module to set up `OIDC` for GitHub Actions is available [here](https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest).  


> **NOTE**: **WAIT** until first CI run on github actions before cloning your new project.
<!-- END_TEMPLATE_DOCUMENTATION -->



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_admin_user_iam_policies"></a> [admin\_user\_iam\_policies](#input\_admin\_user\_iam\_policies) | Admin user IAM policies | `list(string)` | no |
| <a name="input_admin_users"></a> [admin\_users](#input\_admin\_users) | IAM users (username) to add to the `Admins` group. | `list(string)` | no |
| <a name="input_assume_role_arn"></a> [assume\_role\_arn](#input\_assume\_role\_arn) | AWS role to assume when provisioning resources | `string` | no |
| <a name="input_basic_user_iam_policies"></a> [basic\_user\_iam\_policies](#input\_basic\_user\_iam\_policies) | Basic user IAM policies | `list(string)` | no |
| <a name="input_basic_users"></a> [basic\_users](#input\_basic\_users) | IAM users (username) to add to the `Viewers` group. | `list(string)` | no |
| <a name="input_budget_alert_emails"></a> [budget\_alert\_emails](#input\_budget\_alert\_emails) | n/a | `list(string)` | no |
| <a name="input_budget_alert_thresholds"></a> [budget\_alert\_thresholds](#input\_budget\_alert\_thresholds) | What points (percentage) should billing alerts be sent | `list(number)` | no |
| <a name="input_budget_currency"></a> [budget\_currency](#input\_budget\_currency) | The 3-letter currency code as defined in ISO 4217 | `string` | no |
| <a name="input_dev_user_iam_policies"></a> [dev\_user\_iam\_policies](#input\_dev\_user\_iam\_policies) | Dev user IAM policies | `list(string)` | no |
| <a name="input_dev_users"></a> [dev\_users](#input\_dev\_users) | IAM users (username) to add to the `Developers` group. | `list(string)` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Current Environment | `string` | no |
| <a name="input_monthly_budget"></a> [monthly\_budget](#input\_monthly\_budget) | Monthly budget | `string` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to prepend to resources (for easy identification). | `string` | no |
| <a name="input_region"></a> [region](#input\_region) | Default AWS region. | `string` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Common Tags | `map(string)` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |
<!-- END_TF_DOCS -->
