variable "group" {
  description = "Name of the group that can assume the billing role."
  type        = string
}

variable "notifications_topic_arn" {
  description = "ARN of the SNS topic which contains billing notifications."
  type        = string
}
