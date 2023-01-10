variable "s3_bucket_name" {
  type = string
  # default     = "static-site-bucket"
  description = "Static Site Bucket Name"
}

variable "tags" {
  type        = list(string)
  description = "Tags to be added to the module"
  default     = []
}
