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

variable "pagerduty_global_integration_url" {
  description = <<-EOT
  The endpoint is generally used for integrations that have an inbuilt event transformer on pagerduty side.
  - ref. [Amazon CloudWatch Integration Guide](https://support.pagerduty.com/docs/aws-cloudwatch-integration-guide)
  EOT
  type        = string
  default     = "https://events.pagerduty.com/x-ere/"
}

variable "pagerduty_service_integration_url" {
  description = <<-EOT
  To configure an event, please use the integration_key in the following interpolation.
  - ref. [Amazon CloudWatch Integration Guide](https://support.pagerduty.com/docs/aws-cloudwatch-integration-guide)
  EOT
  type        = string
  default     = "https://events.pagerduty.com/integration/"
}

variable "pagerduty_service_integration_url_slug" {
  description = <<-EOT
  To configure an event, please use the integration_key in the following interpolation.
  - ref. [Amazon CloudWatch Integration Guide](https://support.pagerduty.com/docs/aws-cloudwatch-integration-guide)
  EOT
  type        = string
  default     = "/enqueue"
}

variable "trigger_list_bucket_call_count" {
  default = false
}

variable "trigger_tag_cahnge_on_recourse_value" {
  default = "none"
}
