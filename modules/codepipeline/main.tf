# Build Codestar connection config to Github
resource "aws_codestarconnections_connection" "github" {
  name          = var.github_connection_name
  provider_type = "GitHub"

  tags = var.tags
}

# Build IAM Role for Codepipeline
resource "aws_iam_role" "this" {
  name = "${var.codepipeline_name}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  EOF

  tags = var.tags
}

# Build S3 Artifact Storage
resource "aws_s3_bucket" "this" {
  bucket   = "${var.codepipeline_name}-artifact-storage"
  tags_all = var.tags
}

# Build S3 ACL
resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

# Build IAM policy to allow access to S3
data "aws_iam_policy_document" "s3_policy" {
  # S3
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.this.arn}",
      "${aws_s3_bucket.this.arn}/*", "*",
    ]
  }

  # CodeStar
  statement {
    actions   = ["codestar-connections:UseConnection"]
    resources = [aws_codestarconnections_connection.github.arn]
  }

  # Lambda
  statement {
    actions   = ["lambda:*"]
    resources = [module.invalidate_cache_lambda.lambda_function_arn]
  }

  # Codebuild
  statement {
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "this" {
  name = "${var.codepipeline_name}-policy"
  role = aws_iam_role.this.id

  policy = data.aws_iam_policy_document.s3_policy.json
}

# Codepipeline config
resource "aws_codepipeline" "this" {
  name     = var.codepipeline_name
  role_arn = aws_iam_role.this.arn

  artifact_store {
    location = aws_s3_bucket.this.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = 1
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn        = aws_codestarconnections_connection.github.arn
        FullRepositoryId     = var.github_repository
        BranchName           = var.github_branch
        OutputArtifactFormat = "CODE_ZIP"
        DetectChanges        = "true"
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      input_artifacts = ["source_output"]
      version         = 1
      configuration = {
        BucketName = var.s3_bucket_name
        Extract    = "true"
      }
    }
  }

  stage {
    name = "CacheInvalidation"
    action {
      name            = "InvalidateCache"
      category        = "Invoke"
      owner           = "AWS"
      provider        = "Lambda"
      input_artifacts = ["source_output"]
      version         = 1
      configuration = {
        FunctionName   = module.invalidate_cache_lambda.lambda_function_name
        UserParameters = "{\"distributionId\": \"${var.cloudfront_id}\", \"objectPaths\": [\"/*\"]}"
      }
    }
  }

  tags = var.tags
}