variable "pagerduty_token" {
  description = "The authorization token."
  type        = string
}

variable "service_id" {
  description = "ID of existing service."
  type        = string
}

/*
{
  "orchestration_path": {
    "sets": [
      {
        "id": "start",
        "rules": [
          {
            "label": "Always apply some consistent event transformations to all events",
            "id": "c91f72f3",
            "conditions": [],
            "actions": {
              "variables": [
                {
                  "name": "hostname",
                  "path": "event.component",
                  "value": "hostname: (.*)",
                  "type": "regex"
                }
              ],
              "extractions": [
                {
                  "template": "{{variables.hostname}}",
                  "target": "event.custom_details.hostname"
                },
                {
                  "source": "event.source",
                  "regex": "www (.*) service",
                  "target": "event.source"
                }
              ],
              "route_to": "step-two"
            }
          }
        ]
      },
    ]
  }
}
*/

variable "rule_id" {
  description = "The ID of this set of rules."
  type        = string
  default     = "start"
}

variable "rules" {
  description = "The Service Orchestration evaluates Events sent to this Service against each of its rules, beginning with the rules in the \"start\" set."
  type        = list(any)
  default     = []
}

locals {
  service_orchestration_sets = {
    orchestration_path = {
      sets = [
        {
          id : var.rule_id,
          rules : var.rules,
        },
      ]
    }
  }

  config_sets = replace(jsonencode(local.service_orchestration_sets), "'", "'\\''")
}
