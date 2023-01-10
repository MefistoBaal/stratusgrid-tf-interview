locals {
    common_vars = yamldecode(file("common_vars.yaml"))
    remote_bucket = "terraform-deploy-fragments-${local.common_vars.aws_account}-${local.common_vars.aws_region}"
}

remote_state {
    backend = "s3"
    generate = {
        path = "state.tf"
        if_exists = "overwrite_terragrunt"
    }

    config = {
        encrypt = true
        bucket = local.remote_bucket
        region = local.common_vars.aws_region
        key = format("mb-${local.common_vars.environment}-stratusgrid.tfstate")
    }
}