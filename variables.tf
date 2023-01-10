variable "environment" {
  type        = string
  default     = "dev"
  description = "The Enviroment where this module are deployed"
}

variable "aws_account" {
  type        = string
  description = "The AWS Account ID used"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region"
}

variable "s3_static_site_bucket_name" {
  type        = string
  description = "Static site bucket name"
}

variable "codepipeline_name" {
  type        = string
  description = "Name of Codepipeline pipe"
}

variable "github_repository" {
  type        = string
  description = "account/repository path of GitHub"
}

variable "repository_branch" {
  type        = string
  description = "Repository branch that trigger the CICD process"
  default     = "master"
}

variable "source_repo" {
  type = string
  default = "https://github.com/MefistoBaal/stratusgrid-tf-interview"
}