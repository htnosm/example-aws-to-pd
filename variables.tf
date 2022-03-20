variable "resource_prefix" {
  description = "Name to be used on all resources as prefix"
  type        = string
  default     = "example-aws-to-pd"
}

variable "pagerduty_token" {
  description = "The authorization token."
  type        = string
}

variable "pagerduty_escalation_policy_name" {
  description = "The name to use to find an escalation policy."
  type        = string
  default     = "Default"
}

variable "trigger_list_bucket_call_count" {
  default = false
}

variable "trigger_tag_cahnge_on_recourse_value" {
  default = "none"
}
