/**
 * # pagerduty-service-orchestration
 *
 * Create a "Orchestration Rule" in PargerDuty Service.
 *
 * `event_orchestrations` does not support, so it execute PagerDuty API.
 * - ref.
 *   - [API Reference \| PagerDuty Developer Documentation](https://developer.pagerduty.com/api-reference)
 *   - [Add support for event\_orchestrations API · Issue \#465](https://github.com/PagerDuty/terraform-provider-pagerduty/issues/465)
 */

terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.2"
    }
  }
}

resource "null_resource" "rules" {
  count = length(var.rules) == 0 ? 0 : 1
  triggers = {
    config_sets = local.config_sets
  }

  provisioner "local-exec" {
    command = <<EOF
#!/bin/bash

TOKEN="${var.pagerduty_token}"

set -x
curl -sSf --request PUT \
  --url https://api.pagerduty.com/event_orchestrations/services/${var.service_id} \
  --header 'Accept: application/vnd.pagerduty+json;version=2' \
  --header 'Authorization: Token token='$${TOKEN}'' \
  --header 'Content-Type: application/json' \
  --data '${local.config_sets}'
EOF
  }
}

data "external" "rules" {
  depends_on = [
    null_resource.rules
  ]

  program = ["bash", "${path.module}/scripts/get-service-orchestration.sh"]

  query = {
    # arbitrary map from strings to strings, passed
    # to the external program as the data query.
    pagerduty_token = var.pagerduty_token
    id              = var.service_id
  }
}

output "rules" {
  value = data.external.rules.result
}
