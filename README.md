# terraform-aws-role

https://registry.terraform.io/modules/BotTech/role/aws/

Terraform module for AWS which creates an IAM role.

The quickest way to get started is to refer to one of the examples above 👆.

## Configuration

### Groups

Create any groups that you may need:

```hcl-terraform
resource "aws_iam_group" "developers" {
  name = "Developers"
}
```

### Policies

Also create policies that you want to be attached to the role:

```hcl-terraform
resource "aws_iam_policy" "developer" {
  description = "Allow a user to develop applications."
  name        = "Developer"
  policy      = data.aws_iam_policy_document.developer.json
}

// Policy document not shown.
```

## Module

Now that you have all the prerequisites you can configure the module:

```hcl-terraform
module "developer_role" {
  source  = "BotTech/role/aws"
  version = "1.0.0"

  account_ids = [
    data.aws_caller_identity.current.account_id,
    var.parent_account_id
  ]
  description = "Provides developer access to resources."
  groups = [
    aws_iam_group.developers.name
  ]
  name        = "CommUnityDeveloper"
  policies    = {
    resources = aws_iam_policy.developer.arn
    ecr       = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  }
}
```

## License

```text
Copyright 2020 BotTech.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this repository except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

[create a codebuild service role]: https://docs.aws.amazon.com/codebuild/latest/userguide/setting-up.html#setting-up-service-role
[create a personal access token]: https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html#creating-a-personal-access-token
[integration gitlab with aws codebuild]: https://gitlab.com/gitlab-org/gitlab/-/issues/19081
[oauth application in the admin area]: https://docs.gitlab.com/ee/integration/oauth_provider.html#oauth-applications-in-the-admin-area
[urlencoder]: https://www.urlencoder.io/
