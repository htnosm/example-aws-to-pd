data "pagerduty_vendor" "custom_event_transformer" {
  name = "Custom Event Transformer"
}

resource "pagerduty_service_integration" "this" {
  name    = var.integration_name
  service = var.service_id
  vendor  = data.pagerduty_vendor.custom_event_transformer.id
}

locals {
  source_code_path = var.source_code_path == "default.js" ? "${path.module}/templates/default.js" : var.source_code_path
  source_code      = join("\\n", [for line in split("\n", file(local.source_code_path)) : replace(line, "\"", "\\\"")])
  debug_mode       = var.debug_mode ? "debug_on" : "debug_off"

  config_data = templatefile("${path.module}/templates/custom_event_transformer_config.json", {
    code  = local.source_code,
    debug = local.debug_mode,
  })
}

# pagerduty_service_integration does not support advanced options
# ref. (similar issue) [\[Feature Request\] Allow pagerduty\_service\_integration to modify CloudWatch "Correlate events by" and "Derive name from" options · Issue \#260 · PagerDuty/terraform\-provider\-pagerduty · GitHub](https://github.com/PagerDuty/terraform-provider-pagerduty/issues/260)
resource "null_resource" "pagerduty_service_integration_config" {
  triggers = {
    config_data = local.config_data
  }

  provisioner "local-exec" {
    command = <<EOF
#!/bin/bash

TOKEN="${var.pagerduty_token}"
SERVICE_ID="${var.service_id}"
INTEGRATION_ID="${pagerduty_service_integration.this.id}"

set -x
curl -sSf --request PUT \
  --url "https://api.pagerduty.com/services/$${SERVICE_ID}/integrations/$${INTEGRATION_ID}" \
  --header 'Accept: application/vnd.pagerduty+json;version=2' \
  --header 'Authorization: Token token='$${TOKEN}'' \
  --header 'Content-Type: application/json' \
  --data '${local.config_data}'
EOF
  }
}
