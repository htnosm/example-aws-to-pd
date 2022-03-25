variable "integration_name" {
  description = "The name of the service integration."
  type        = string
  default     = "Custom Event Transformer"
}

variable "service_id" {
  description = "The ID of the service the integration should belong to."
  type        = string
}

variable "source_code_path" {
  description = "path to the function's source code within the local filesystem. (Do not use single quotes in the source.)"
  type        = string
  default     = "default.js"
}

variable "debug_mode" {
  description = "Debug mode (send an event to your service if code produces errors)."
  type        = bool
  default     = true
}

variable "pagerduty_token" {
  description = "The v2 authorization token."
  type        = string
  sensitive   = true
}
