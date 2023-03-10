module "s3_static_site" {
  source         = "./modules/s3-static-site"
  s3_bucket_name = var.s3_static_site_bucket_name

  tags = merge(local.common_tags, { "Deployment" = "s3_static_site" })
}

module "cicd" {
  source = "./modules/codepipeline"

  depends_on = [module.s3_static_site]

  codepipeline_name = var.codepipeline_name
  github_repository = var.github_repository
  github_branch     = var.repository_branch
  s3_bucket_name    = module.s3_static_site.s3_bucket_name
  cloudfront_id = module.cloudfront.cloudfront_id

  tags = merge(local.common_tags, { "Deployment" = "CICD" })
}

module "cloudfront" {
  source = "./modules/cloudfront"

  depends_on = [module.s3_static_site]

  s3_bucket_regional_domain_name = module.s3_static_site.s3_regional_domain_name
  s3_bucket_arn                  = module.s3_static_site.s3_bucket_arn
  s3_bucket_name                 = module.s3_static_site.s3_bucket_name

  tags = merge(local.common_tags, { "Deployment" = "Cloudfront" })
}