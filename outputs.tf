output "static_website_cloudfront_dns" {
  value = module.cloudfront.cloudfront_url
}

output "static_website_s3_bucket" {
  value = module.s3_static_site.s3_bucket_name
}