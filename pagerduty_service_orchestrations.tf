module "service_orchestration" {
  source = "./modules/pagerduty-service-orchestration"

  pagerduty_token = var.pagerduty_token

  service_id = pagerduty_service.example_orchestration.id

  rules = [
    {
      label = null,
      conditions = [
        # CloudWatch Metric Alarm
        {
          expression = "raw_event.TopicArn matches '${module.sns_topic_cw_alarm.arn}' and raw_event.Subject matches part 'ALARM:'",
        },
        # EventBridge
      ]
      actions = {
        severity = "warning"
      }
    },
    {
      label      = null,
      conditions = []
      actions = {
        event_action = "resolve"
      }
    },
  ]
}
