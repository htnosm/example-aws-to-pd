##########
# CloudWatch Metric Alarm
##########
module "sns_topic_cw_alarm" {
  source = "./modules/sns-topic-with-service"

  name        = "${var.resource_prefix}-cw-alarm"
  identifiers = []
}

# Global Ruleset
resource "aws_sns_topic_subscription" "cw_alarm_to_global_ruleset" {
  topic_arn              = module.sns_topic_cw_alarm.arn
  protocol               = "https"
  endpoint               = "${var.pagerduty_global_integration_url}${data.pagerduty_ruleset.global.routing_keys[0]}"
  endpoint_auto_confirms = true
}

# Service Integration "CloudWatch"
resource "aws_sns_topic_subscription" "cw_alarm_to_service_integration_cloudwatch" {
  topic_arn              = module.sns_topic_cw_alarm.arn
  protocol               = "https"
  endpoint               = "${var.pagerduty_service_integration_url}${pagerduty_service_integration.cloudwatch.integration_key}${var.pagerduty_service_integration_url_slug}"
  endpoint_auto_confirms = true
}

# Global Orchestration
resource "aws_sns_topic_subscription" "cw_alarm_to_global_orchestration" {
  topic_arn              = module.sns_topic_cw_alarm.arn
  protocol               = "https"
  endpoint               = "${var.pagerduty_global_integration_url}${module.global_orchestration_cw_alarm.result.integration_key}"
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
