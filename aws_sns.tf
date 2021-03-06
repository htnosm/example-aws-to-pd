##########
# CloudWatch Metric Alarm
##########
module "sns_topic_cw_alarm" {
  source = "./modules/sns-topic-with-service"

  name        = "${var.resource_prefix}-cw-alarm"
  identifiers = []
}

# Service Integration "CloudWatch"
resource "aws_sns_topic_subscription" "cw_alarm_to_service_integration_cloudwatch" {
  count                  = var.elable_subscriptions.cw_alarm_to_service_integration_cloudwatch ? 1 : 0
  topic_arn              = module.sns_topic_cw_alarm.arn
  protocol               = "https"
  endpoint               = "${var.pagerduty_service_integration_url}${pagerduty_service_integration.cloudwatch.integration_key}${var.pagerduty_service_integration_url_slug}"
  endpoint_auto_confirms = true
}

# Global Ruleset
resource "aws_sns_topic_subscription" "cw_alarm_to_global_ruleset" {
  count                  = var.elable_subscriptions.cw_alarm_to_global_ruleset ? 1 : 0
  topic_arn              = module.sns_topic_cw_alarm.arn
  protocol               = "https"
  endpoint               = "${var.pagerduty_global_integration_url}${data.pagerduty_ruleset.global.routing_keys[0]}"
  endpoint_auto_confirms = true
}

# Global Orchestration
resource "aws_sns_topic_subscription" "cw_alarm_to_global_orchestration" {
  count                  = var.elable_subscriptions.cw_alarm_to_global_orchestration ? 1 : 0
  topic_arn              = module.sns_topic_cw_alarm.arn
  protocol               = "https"
  endpoint               = "${var.pagerduty_global_integration_url}${module.global_orchestration.result.integration_key}"
  endpoint_auto_confirms = true
}

##########
# EventBridge
##########
module "sns_topic_eventbridge" {
  source = "./modules/sns-topic-with-service"

  name        = "${var.resource_prefix}-eventbridge"
  identifiers = ["events.amazonaws.com"]
}

# Service Integration "Email"
resource "aws_sns_topic_subscription" "eventbridge_to_integration_email" {
  count                  = var.elable_subscriptions.eventbridge_to_integration_email ? 1 : 0
  topic_arn              = module.sns_topic_eventbridge.arn
  protocol               = "email"
  endpoint               = pagerduty_service_integration.email.integration_email
  endpoint_auto_confirms = false
}
resource "aws_sns_topic_subscription" "eventbridge_to_integration_email_json" {
  count                  = var.elable_subscriptions.eventbridge_to_integration_email_json ? 1 : 0
  topic_arn              = module.sns_topic_eventbridge.arn
  protocol               = "email-json"
  endpoint               = pagerduty_service_integration.email_json.integration_email
  endpoint_auto_confirms = false
}

# Service Integration "Custom Event Transformer"
resource "aws_sns_topic_subscription" "eventbridge_to_integration_custom_event_transfer" {
  count                  = var.elable_subscriptions.eventbridge_to_integration_custom_event_transfer ? 1 : 0
  topic_arn              = module.sns_topic_eventbridge.arn
  protocol               = "https"
  endpoint               = module.pagerduty_service_integration_custom_event_transfer.integration_url
  endpoint_auto_confirms = false
}
resource "aws_sns_topic_subscription" "eventbridge_to_integration_custom_event_transfer_v2" {
  count                  = var.elable_subscriptions.eventbridge_to_integration_custom_event_transfer_v2 ? 1 : 0
  topic_arn              = module.sns_topic_eventbridge.arn
  protocol               = "https"
  endpoint               = module.pagerduty_service_integration_custom_event_transfer_v2.integration_url
  endpoint_auto_confirms = false
}
resource "aws_sns_topic_subscription" "eventbridge_to_integration_custom_event_transfer_sns" {
  count                  = var.elable_subscriptions.eventbridge_to_integration_custom_event_transfer_sns ? 1 : 0
  topic_arn              = module.sns_topic_eventbridge.arn
  protocol               = "https"
  endpoint               = module.pagerduty_service_integration_custom_event_transfer_sns.integration_url
  endpoint_auto_confirms = false
}

# Service Integration "Custom Event Transformer"
resource "aws_sns_topic_subscription" "eventbridge_to_integration_events_api_v2" {
  count                  = var.elable_subscriptions.eventbridge_to_integration_events_api_v2 ? 1 : 0
  topic_arn              = module.sns_topic_eventbridge.arn
  protocol               = "lambda"
  endpoint               = module.lambda_events_api_v2.function_arn
  endpoint_auto_confirms = true
}

# Global Ruleset
resource "aws_sns_topic_subscription" "eventbridge_to_global_ruleset" {
  count                  = var.elable_subscriptions.eventbridge_to_global_ruleset ? 1 : 0
  topic_arn              = module.sns_topic_eventbridge.arn
  protocol               = "https"
  endpoint               = "${var.pagerduty_global_integration_url}${data.pagerduty_ruleset.global.routing_keys[0]}"
  endpoint_auto_confirms = true
}

# Global Orchestration
resource "aws_sns_topic_subscription" "eventbridge_to_global_orchestration" {
  count                  = var.elable_subscriptions.eventbridge_to_global_orchestration ? 1 : 0
  topic_arn              = module.sns_topic_eventbridge.arn
  protocol               = "https"
  endpoint               = "${var.pagerduty_global_integration_url}${module.global_orchestration.result.integration_key}"
  endpoint_auto_confirms = true
}

# Global Ruleset (Email)
resource "aws_sns_topic_subscription" "eventbridge_to_global_ruleset_email" {
  count                  = var.elable_subscriptions.eventbridge_to_global_ruleset_email ? 1 : 0
  topic_arn              = module.sns_topic_eventbridge.arn
  protocol               = "email"
  endpoint               = "${data.pagerduty_ruleset.global.routing_keys[0]}@${local.pagerduty_email_domain}"
  endpoint_auto_confirms = false
}
resource "aws_sns_topic_subscription" "eventbridge_to_global_ruleset_email_json" {
  count                  = var.elable_subscriptions.eventbridge_to_global_ruleset_email_json ? 1 : 0
  topic_arn              = module.sns_topic_eventbridge.arn
  protocol               = "email-json"
  endpoint               = "${data.pagerduty_ruleset.global.routing_keys[0]}@${local.pagerduty_email_domain}"
  endpoint_auto_confirms = false
}

# Global Orchestration (Email)
resource "aws_sns_topic_subscription" "eventbridge_to_global_orchestration_email" {
  count                  = var.elable_subscriptions.eventbridge_to_global_orchestration_email ? 1 : 0
  topic_arn              = module.sns_topic_eventbridge.arn
  protocol               = "email"
  endpoint               = "${module.global_orchestration.result.integration_key}@${local.pagerduty_email_domain}"
  endpoint_auto_confirms = false
}
resource "aws_sns_topic_subscription" "eventbridge_to_global_orchestration_email_json" {
  count                  = var.elable_subscriptions.eventbridge_to_global_orchestration_email_json ? 1 : 0
  topic_arn              = module.sns_topic_eventbridge.arn
  protocol               = "email-json"
  endpoint               = "${module.global_orchestration.result.integration_key}@${local.pagerduty_email_domain}"
  endpoint_auto_confirms = false
}

# Global Ruleset (API)
resource "aws_sns_topic_subscription" "eventbridge_to_global_ruleset_lambda" {
  count                  = var.elable_subscriptions.eventbridge_to_global_ruleset_lambda ? 1 : 0
  topic_arn              = module.sns_topic_eventbridge.arn
  protocol               = "lambda"
  endpoint               = module.lambda_global_ruleset.function_arn
  endpoint_auto_confirms = true
}

# Global Orchestration (API)
resource "aws_sns_topic_subscription" "eventbridge_to_global_orchestration_lambda" {
  count                  = var.elable_subscriptions.eventbridge_to_global_orchestration_lambda ? 1 : 0
  topic_arn              = module.sns_topic_eventbridge.arn
  protocol               = "lambda"
  endpoint               = module.lambda_global_orchestration.function_arn
  endpoint_auto_confirms = true
}
