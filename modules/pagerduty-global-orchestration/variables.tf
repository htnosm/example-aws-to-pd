variable "pagerduty_token" {
  description = "The authorization token."
  type        = string
}

/*
{
  "orchestration": {
    "name": "New Orchestration",
    "description": "This is a newly created orchestration",
    "team": {
      "id": "PXD0WR8"
    }
  }
}
*/
variable "name" {
  description = "Name of the Orchestration."
  type        = string
}

variable "description" {
  description = "A description of this Orchestration's purpose."
  type        = string
}

variable "team_id" {
  description = "Reference to the team that owns the Orchestration. If none is specified, only admins have access."
  type        = string
  default     = ""
}

/*
{
  "orchestration_path": {
    "sets": [
      {
        "id": "start",
        "rules": [
          {
            "label": "Events relating to our relational database",
            "id": "1c26698b",
            "conditions": [
              {
                "expression": "event.summary matches part '\''database'\''"
              },
              {
                "expression": "event.source matches regex '\''db[0-9]+-server'\''"
              }
            ],
            "actions": {
              "route_to": "PB31XBA"
            }
          },
          {
            "label": "Events relating to our www app server",
            "id": "d9801904",
            "conditions": [
              {
                "expression": "event.summary matches part '\''www'\''"
              }
            ],
            "actions": {
              "route_to": "PC2D9ML"
            }
          }
        ]
      }
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
  description = "The Router evaluates Events against these Rules, one at a time, and routes each Event to a specific Service based on the first rule that matches."
  type = list(object({
    label : string,
    conditions : list(object({
      expression : string
    })),
    actions : object({
      route_to : string
    })
  }))
  default = []
}

locals {
  global_orchestration_sets = {
    orchestration_path = {
      sets = [
        {
          id : var.rule_id,
          rules : var.rules,
        },
      ]
    }
  }

  config_sets = replace(jsonencode(local.global_orchestration_sets), "'", "'\\''")
}
