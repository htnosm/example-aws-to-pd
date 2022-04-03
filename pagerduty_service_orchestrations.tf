module "service_orchestration" {
  source = "./modules/pagerduty-service-orchestration"

  pagerduty_token = var.pagerduty_token

  service_id = pagerduty_service.example_orchestration.id

  rules = [
    # CloudWatch Metric Alarm
    {
      label = null,
      conditions = [
        {
          expression = "raw_event.TopicArn matches '${module.sns_topic_cw_alarm.arn}' and raw_event.Subject matches part 'ALARM:'",
        },
      ]
      actions = {
        severity = "warning"
      }
    },
    # EventBridge
    {
      label = null,
      conditions = [
        {
          expression = "raw_event.TopicArn matches '${module.sns_topic_eventbridge.arn}'",
        },
      ]
      actions = {
        severity  = "warning"
        variables = []

        variables = [
          {
            name  = "topic_name"
            path  = "raw_event.TopicArn"
            type  = "regex"
            value = "^.*:(.*)"
          },
          {
            name  = "detail_type"
            path  = "raw_event.Message"
            type  = "regex"
            value = "^.*\"detail-type\":\"([^\"]*)\".*$"
          },
          {
            name  = "message_id"
            path  = "raw_event.MessageId"
            type  = "regex"
            value = "(.*)"
          },
        ]

        extractions = [
          {
            target   = "event.summary"
            template = "{{variables.topic_name}}: {{variables.detail_type}}"
          },
          {
            target   = "event.dedup_key"
            template = "{{variables.message_id}}"
          },
        ]
      }
    },
    # resolve
    {
      label = null,
      actions = {
        event_action = "resolve"
      }
    },
  ]
}

/*
# for debug
output "service_orchestration_rules" {
  value = module.service_orchestration.rules.sets
}
*/
