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

locals {
  pagerduty_html_url     = replace(pagerduty_service.example.html_url, "/\\/service-directory\\/.*/", "")
  pagerduty_email_domain = replace(local.pagerduty_html_url, "https://", "")
}

output "pagerduty_html_url" {
  value = local.pagerduty_html_url
}

resource "pagerduty_service" "example_rulesets" {
  name                    = "${var.resource_prefix}-rulesets"
  description             = "Managed by Terraform, with Rulesets"
  auto_resolve_timeout    = "null" # Disabled if set to the "null"
  acknowledgement_timeout = "null" # Disabled if set to the "null"
  escalation_policy       = data.pagerduty_escalation_policy.example.id
  alert_creation          = "create_alerts_and_incidents"

  incident_urgency_rule {
    type    = "constant"
    urgency = "severity_based"
  }
}

resource "pagerduty_service" "example_orchestration" {
  name                    = "${var.resource_prefix}-orchestration"
  description             = "Managed by Terraform, with Event Orchestration"
  auto_resolve_timeout    = "null" # Disabled if set to the "null"
  acknowledgement_timeout = "null" # Disabled if set to the "null"
  escalation_policy       = data.pagerduty_escalation_policy.example.id
  alert_creation          = "create_alerts_and_incidents"

  incident_urgency_rule {
    type    = "constant"
    urgency = "severity_based"
  }
}

resource "pagerduty_service" "example_rulesets_email" {
  name                    = "${var.resource_prefix}-rulesets-email"
  description             = "Managed by Terraform, with Rulesets"
  auto_resolve_timeout    = "null" # Disabled if set to the "null"
  acknowledgement_timeout = "null" # Disabled if set to the "null"
  escalation_policy       = data.pagerduty_escalation_policy.example.id
  alert_creation          = "create_alerts_and_incidents"

  incident_urgency_rule {
    type    = "constant"
    urgency = "severity_based"
  }
}

resource "pagerduty_service" "example_orchestration_email" {
  name                    = "${var.resource_prefix}-orchestration-email"
  description             = "Managed by Terraform, with Event Orchestration"
  auto_resolve_timeout    = "null" # Disabled if set to the "null"
  acknowledgement_timeout = "null" # Disabled if set to the "null"
  escalation_policy       = data.pagerduty_escalation_policy.example.id
  alert_creation          = "create_alerts_and_incidents"

  incident_urgency_rule {
    type    = "constant"
    urgency = "severity_based"
  }
}
