output "assume_role_policy_arn" {
  description = "ARN of the policy which permits assuming the role."
  value       = module.amplify_role.assume_role_policy_arn
}

output "role_arn" {
  description = "ARN of the role."
  value       = module.amplify_role.role_arn
}

output "role_name" {
  description = "Name of the role."
  value       = module.amplify_role.role_name
}
