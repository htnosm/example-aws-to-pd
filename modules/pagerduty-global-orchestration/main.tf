# event_orchestrations does not support
# ref. [Add support for event\_orchestrations API · Issue \#465](https://github.com/PagerDuty/terraform-provider-pagerduty/issues/465)
locals {
  global_orchestration = {
    orchestration = {
      name        = var.name
      description = var.description
    }
  }

  global_orchestration_with_team = {
    orchestration = {
      name        = var.name
      description = var.description
      team = {
        id = var.team_id
      }
    }
  }

  config_data = var.team_id == "" ? jsonencode(local.global_orchestration) : jsonencode(local.global_orchestration_with_team)
}

resource "null_resource" "this" {
  triggers = {
    config_data = local.config_data
  }

  provisioner "local-exec" {
    command = <<EOF
#!/bin/bash

TOKEN="${var.pagerduty_token}"

set -x
curl -sSf --request POST \
  --url https://api.pagerduty.com/event_orchestrations \
  --header 'Accept: application/vnd.pagerduty+json;version=2' \
  --header 'Authorization: Token token='$${TOKEN}'' \
  --header 'Content-Type: application/json' \
  --data '${local.config_data}'
EOF
  }
}

data "external" "this" {
  depends_on = [
    null_resource.this
  ]

  program = ["bash", "${path.module}/scripts/get-event-orchestration.sh"]

  query = {
    # arbitrary map from strings to strings, passed
    # to the external program as the data query.
    pagerduty_token = var.pagerduty_token
    name            = var.name
  }
}

output "result" {
  value = data.external.this.result
}
