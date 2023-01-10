output "cloudfront_url" {
  value       = aws_cloudfront_distribution.this.domain_name
  description = "Public domain where distribution is exposed"
}
