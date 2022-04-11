variable "name" {
  type        = string
  description = "Name that is used for the created resources."
}

variable "lambda_function_runtime" {
  type    = string
  default = "python3.9"
}

variable "lambda_function_timeout" {
  type    = number
  default = 15
}

variable "lambda_function_log_retention_in_days" {
  type        = number
  description = "Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0(never)"
  default     = 7
}

variable "integration_key" {
  type        = string
  description = "This is the 32 character Integration Key of PagerDuty for an integration on a service or on a global ruleset or on a global orchestration."
}
