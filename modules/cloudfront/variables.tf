# variable "cloudfront_aliases" {
#   type        = list(string)
#   description = "URLs/DNS used to expose Cloudfront distribution. Custom domain"
# }

variable "cloudfront_origin_id" {
  type        = string
  default     = "StaticWebsiteOrigin"
  description = "Default name for the origin"
}

variable "s3_bucket_regional_domain_name" {
  type        = string
  description = "Generated S3 regional domain name"
}

variable "s3_bucket_arn" {
  type        = string
  description = "S3 Bucket ARN to use as origin"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "acm_certificate_arn" {
  type        = string
  default     = ""
  description = "ACM Certificated allowed to be used by Cloudfront | SSL"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the module"
  default     = {}
}
