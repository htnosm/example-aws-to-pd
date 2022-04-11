module "global_orchestration" {
  source = "./modules/pagerduty-global-orchestration"

  pagerduty_token = var.pagerduty_token

  name        = var.resource_prefix
  description = "Managed by Terraform"

  rules = [
    {
      label = null,
      conditions = [
        # CloudWatch Metric Alarm
        {
          expression = "raw_event.TopicArn matches '${module.sns_topic_cw_alarm.arn}'",
        },
        # EventBridge
        {
          expression = "raw_event.TopicArn matches '${module.sns_topic_eventbridge.arn}'",
        },
        # EventBridge Email-JSON
        {
          expression = "event.custom_details.subject matches 'AWS Notification Message' and event.custom_details.plain_body matches part '\"TopicArn\" : \"${module.sns_topic_eventbridge.arn}\"'",
        },
        # Lambda
        {
          expression = "event.source matches '${module.sns_topic_eventbridge.arn}'",
        },
      ]
      actions = {
        route_to = pagerduty_service.example_orchestration.id
      }
    },
    {
      label = null,
      conditions = [
        # EventBridge Email
        {
          expression = "event.custom_details.subject matches 'AWS Notification Message' and event.custom_details.plain_body matches part '?SubscriptionArn=${module.sns_topic_eventbridge.arn}:'",
        },
      ]
      actions = {
        route_to = pagerduty_service.example_orchestration_email.id
      }
    },
  ]
}

output "global_orchestration_html_url" {
  value = module.global_orchestration.result.html_url
}
