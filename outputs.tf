output "assume_role_policy_arn" {
  description = "ARN of the policy which permits assuming the role."
  value       = aws_iam_policy.assume_role.arn
}

output "role_arn" {
  description = "ARN of the role."
  value       = aws_iam_role.role.arn
}

output "role_name" {
  description = "Name of the role."
  value       = aws_iam_role.role.name
}
