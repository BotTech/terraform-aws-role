module "amplify_role" {
  source  = "BotTech/role/aws"
  version = "1.0.0"

  account_ids = [
    data.aws_caller_identity.current.account_id
  ]
  description = "Provides developer access to Amplify resources."
  groups      = [
    var.group
  ]
  name        = "Developer"
  policies    = {
    resources = aws_iam_policy.amplify_developer.arn
    ecr       = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  }
}

data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "amplify_developer" {
  description = "Allow a user to develop applications using AWS Amplify."
  name        = "AWSAmplifyDeveloper"
  policy      = data.aws_iam_policy_document.amplify_developer.json
}

data "aws_iam_policy_document" "amplify_developer" {
  statement {
    sid       = "AmplifyFullAccess"
    actions   = [
      "amplify:*",
      "apigateway:*",
      "appsync:*",
      "cloudformation:*",
      "cognito-identity:*",
      "cognito-idp:*",
      "dynamodb:*",
      "iam:*",
      "lambda:*",
      "route53:*",
      "s3:*"
    ]
    resources = [
      "*"
    ]
  }
}
