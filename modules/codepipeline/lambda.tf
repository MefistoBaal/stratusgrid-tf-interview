# Policy to allow lambda to add pipe status
data "aws_iam_policy_document" "cloudfront_access_policy" {
  statement {
    actions = [
      "codepipeline:PutJobFailireResult",
      "codepipeline:PutJobSuccessResult",
      "cloudfront:CreateInvalidation"
    ]
    resources = ["*"]
  }
}

# Deploy lambda function to invalidate cache
module "invalidate_cache_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.7.2"

  function_name      = "invalidate_cloudfront_cache"
  description        = "This lambda is triggered by Codepipeline to reset Cloudfront distributions cache"
  handler            = "lambda.lambda_handler"
  runtime            = "python3.9"
  timeout            = 30
  publish            = true
  source_path        = "${path.module}/lambda.py"
  attach_policy_json = true
  policy_json        = data.aws_iam_policy_document.cloudfront_access_policy.json

  tags = var.tags
}