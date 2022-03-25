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
  --url ${data.external.this.result.self}/router \
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

  program = ["bash", "${path.module}/scripts/get-event-orchestration-router.sh"]

  query = {
    # arbitrary map from strings to strings, passed
    # to the external program as the data query.
    pagerduty_token = var.pagerduty_token
    id              = data.external.this.result.id
  }
}

output "rules" {
  value = data.external.rules.result
}
