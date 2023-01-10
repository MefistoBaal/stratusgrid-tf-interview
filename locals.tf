locals {
  common_tags = {
    Environment = var.environment
    SourceRepo = var.source_repo
    Provisioner = "Terraform"
    Terraform = "true"
  }
}