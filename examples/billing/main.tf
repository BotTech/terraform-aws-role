module "billing_role" {
  source  = "BotTech/role/aws"
  version = "1.0.0"

  account_ids = [
    data.aws_caller_identity.current.account_id
  ]
  description = "Provides access to billing information."
  groups      = [
    var.group
  ]
  name        = "Billing"
  policies    = {
    billing       = "arn:aws:iam::aws:policy/job-function/Billing"
    notifications = aws_iam_policy.subscribe_to_billing_notifications.arn
  }
}

data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "subscribe_to_billing_notifications" {
  name        = "SubscribeToBillingNotifications"
  description = "Allow a user to manage their subscription to billing notifications."
  policy      = data.aws_iam_policy_document.subscribe_to_billing_notifications.json
}

data "aws_iam_policy_document" "subscribe_to_billing_notifications" {
  statement {
    actions   = [
      "sns:ConfirmSubscription",
      "sns:GetTopicAttributes",
      "sns:Subscribe"
    ]
    resources = [
      var.notifications_topic_arn
    ]
  }
  statement {
    actions   = [
      "sns:ListTopics"
    ]
    resources = [
      "*"
    ]
  }
}
