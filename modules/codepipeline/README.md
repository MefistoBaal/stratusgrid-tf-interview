# Codepipeline Module

This module creates the Github connections, a Lambda Function and the Codepipeline neccesary to deploy static site file to S3

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_invalidate_cache_lambda"></a> [invalidate\_cache\_lambda](#module\_invalidate\_cache\_lambda) | terraform-aws-modules/lambda/aws | 4.7.2 |

## Resources

| Name | Type |
|------|------|
| [aws_codepipeline.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_codestarconnections_connection.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarconnections_connection) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_iam_policy_document.cloudfront_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudfront_id"></a> [cloudfront\_id](#input\_cloudfront\_id) | Cloudfront distribution Id where static site are deployed | `string` | n/a | yes |
| <a name="input_codepipeline_name"></a> [codepipeline\_name](#input\_codepipeline\_name) | n/a | `string` | n/a | yes |
| <a name="input_github_branch"></a> [github\_branch](#input\_github\_branch) | Github repository branch | `string` | n/a | yes |
| <a name="input_github_connection_name"></a> [github\_connection\_name](#input\_github\_connection\_name) | Github connection name | `string` | `"GithubStratusGridConnection"` | no |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | Github repository path | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the module | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->