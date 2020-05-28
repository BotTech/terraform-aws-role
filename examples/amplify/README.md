# Amplify Example

This is a simple example of using `BotTech/role/aws` to create an IAM role for developing applications with AWS Amplify.

The role has the following policies:
- `AWSAmplifyDeveloper` - a custom policy that allows a user to manage resources with AWS Amplify.
 
It may be assumed by users of the current AWS account who are also in the developers group.

## Configuration

### Group

You will need a developers group:

```hcl-terraform
resource "aws_iam_group" "developers" {
  name = "Developers"
}
```

### Example

```hcl-terraform
module "role_amplify" {
  source  = "BotTech/role/aws//examples/amplify"
  version = "1.0.0"
 
  group = aws_iam_group.developers.name
}
```

## License

![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")

To the extent possible under law, [BotTech] has waived all copyright and related or neighboring rights to
`BotTech/role/aws//examples/amplify`.

[bottech]: https://github.com/BotTech/terraform-aws-role
