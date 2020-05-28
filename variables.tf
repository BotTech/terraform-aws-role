variable "account_ids" {
  description = "IDs of the AWS account that can assume the role."
  type        = set(string)
}

variable "description" {
  description = "Description of the role."
  type        = string
}

variable "groups" {
  default     = []
  description = "Names of the groups that can assume the role."
  type        = set(string)
}

variable "name" {
  description = "Name of the role."
  type        = string
}

variable "policies" {
  description = "Name and ARN of policies to attach to the role."
  type        = map(string)
}
