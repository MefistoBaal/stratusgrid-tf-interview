variable "github_connection_name" {
  type        = string
  default     = "GithubStratusGridConnection"
  description = "Github connection name"
}

variable "codepipeline_name" {
  type = string
}

variable "github_repository" {
  type        = string
  description = "Github repository path"
}

variable "github_branch" {
  type        = string
  description = "Github repository branch"
}

variable "s3_bucket_name" {
  type = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the module"
  default     = {}
}
