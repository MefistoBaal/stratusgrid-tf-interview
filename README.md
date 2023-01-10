# Stratus Grid Terraform Interview

The purpose of this Terraform example is to demonstrate my abilities in Terraform to build understable and scalable solutions.

This Terraform module uses AWS as principal Cloud provider, to deploy a CI/CD pipeline using CodeDeploy to release a Static Site using S3 and Cloudfront.

Static Site Code can be found in: [https://github.com/MefistoBaal/stratusgrid-static-site-interview](https://github.com/MefistoBaal/stratusgrid-static-site-interview)

# Software & Tools Used

- [Terragrunt Locals](https://terragrunt.gruntwork.io/docs/features/locals/)
- [Terragrunt DRY Backend Configurations](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/#keep-your-backend-configuration-dry)
- [Tfenv](https://github.com/tfutils/tfenv)

# How to

## S3 Terraform state provision

This Project uses Terragrunt Locals to improve the S3 bucket provisioning

To deploy/provision a S3 bucket to store the TF state, just run in your CLI and follow the next instructions in your CLI

```bash
terragrunt init
```

**Note:** Terragrunt its only used to help deploy the Terraform state storage, to avoid the need to manually create a bucket, although its also posible to skip this step and manually generate a `state.tf` file with the necessary configuration.

## Terraform variables

In this repo you will found a file called *[terraform.tfvars.template](terraform.tfvars.template)*. You will only need to copy and rename the file to `terraform.tfvars` and change the values for your own values.

# About this module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.49.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cicd"></a> [cicd](#module\_cicd) | ./modules/codepipeline | n/a |
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | ./modules/cloudfront | n/a |
| <a name="module_s3_static_site"></a> [s3\_static\_site](#module\_s3\_static\_site) | ./modules/s3-static-site | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account"></a> [aws\_account](#input\_aws\_account) | The AWS Account ID used | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `"us-east-1"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The Enviroment where this module are deployed | `string` | `"dev"` | no |
| <a name="input_s3_static_site_bucket_name"></a> [s3\_static\_site\_bucket\_name](#input\_s3\_static\_site\_bucket\_name) | Static site bucket name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_static_website_cloudfront_dns"></a> [static\_website\_cloudfront\_dns](#output\_static\_website\_cloudfront\_dns) | n/a |
| <a name="output_static_website_s3_bucket"></a> [static\_website\_s3\_bucket](#output\_static\_website\_s3\_bucket) | n/a |
<!-- END_TF_DOCS -->

# Author

[Santiago Hurtado](https://www.linkedin.com/in/santiago-hurtado/)
