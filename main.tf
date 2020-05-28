resource "aws_iam_role" "role" {
  name               = var.name
  description        = var.description
  assume_role_policy = data.aws_iam_policy_document.account_assume_role.json
}

data "aws_iam_policy_document" "account_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "AWS"
      identifiers = [
      for account_id in var.account_ids :
      // Specifying the root account is the same as just using the account id but this is what
      // we get from using the console so use this format so that it doesn't cause a change.
      "arn:aws:iam::${account_id}:root"
      ]
    }
    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = [
        "true"
      ]
    }
  }
}

resource "aws_iam_policy" "assume_role" {
  name        = "${var.name}AssumeRole"
  description = "Assume the ${var.name} role."
  policy      = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions   = [
      "sts:AssumeRole"
    ]
    resources = [
      aws_iam_role.role.arn
    ]
  }
}

resource "aws_iam_group_policy_attachment" "assume_role" {
  for_each   = var.groups
  group      = each.value
  policy_arn = aws_iam_policy.assume_role.arn
}

resource "aws_iam_role_policy_attachment" "policy" {
  for_each   = var.policies
  role       = aws_iam_role.role.name
  policy_arn = each.value
}
