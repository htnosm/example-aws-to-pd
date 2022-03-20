data "pagerduty_escalation_policy" "example" {
  name = var.pagerduty_escalation_policy_name
}

resource "pagerduty_service" "example" {
  name                    = var.resource_prefix
  description             = "Managed by Terraform"
  auto_resolve_timeout    = "null" # Disabled if set to the "null"
  acknowledgement_timeout = "null" # Disabled if set to the "null"
  escalation_policy       = data.pagerduty_escalation_policy.example.id
  alert_creation          = "create_alerts_and_incidents"

  incident_urgency_rule {
    type    = "constant"
    urgency = "severity_based"
  }
}

resource "pagerduty_service" "example_ni" {
  name                    = "${var.resource_prefix}-ni"
  description             = "Managed by Terraform, without integrations"
  auto_resolve_timeout    = "null" # Disabled if set to the "null"
  acknowledgement_timeout = "null" # Disabled if set to the "null"
  escalation_policy       = data.pagerduty_escalation_policy.example.id
  alert_creation          = "create_alerts_and_incidents"

  incident_urgency_rule {
    type    = "constant"
    urgency = "severity_based"
  }
}
