# Billing Example

This is a simple example of using `BotTech/role/aws` to create an IAM role for accessing billing information.

The role has the following policies:
- `arn:aws:iam::aws:policy/job-function/Billing`
- `SubscribeToBillingNotifications` - a custom policy that allows a user to manage their subscription to billing
  notifications.
 
It may be assumed by users of the current AWS account who are also in the billing group.

## Configuration

### Group

You will need a billing group:

```hcl-terraform
resource "aws_iam_group" "billing" {
  name = "Billing"
}
```

### SNS Topic

```hcl-terraform
resource "aws_sns_topic" "billing_notifications" {
  name = "billing-notifications"
  display_name = "Billing"
}
```

### Example

```hcl-terraform
module "role_billing" {
  source  = "BotTech/role/aws//examples/billing"
  version = "1.0.0"
 
  group                   = aws_iam_group.billing.name
  notifications_topic_arn = aws_sns_topic.billing_notifications.arn
}

// SNS resources not shown.
```

## License

![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")

To the extent possible under law, [BotTech] has waived all copyright and related or neighboring rights to
`BotTech/role/aws//examples/billing`.

[bottech]: https://github.com/BotTech/terraform-aws-role
