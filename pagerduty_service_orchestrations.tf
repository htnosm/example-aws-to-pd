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
        severity = "warning"

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
    # EventBridge Email-JSON
    {
      label = null,
      conditions = [
        {
          expression = "event.custom_details.subject matches 'AWS Notification Message' and event.custom_details.plain_body matches part '\"TopicArn\" : \"${module.sns_topic_eventbridge.arn}\"'",
        },
      ]
      actions = {
        variables = [
          {
            name  = "topic_name"
            path  = "event.custom_details.plain_body"
            type  = "regex"
            value = "^.*\"TopicArn\" : \"(?:[^:]*:){5}([^\"]*)\".*$"
          },
          {
            name  = "detail_type"
            path  = "event.custom_details.plain_body"
            type  = "regex"
            value = "^.*\"Message\" : \".*\"detail-type\\\\\":\\\\\"([^\\\\]*)\\\\\".*$"
          },
          {
            name  = "message_id"
            path  = "event.custom_details.plain_body"
            type  = "regex"
            value = "^.*\"MessageId\" : \"([^\"]*)\".*$"
          },
        ]

        extractions = [
          {
            target   = "event.summary"
            template = "Email-JSON [{{variables.topic_name}}] {{variables.detail_type}}"
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

module "service_orchestration_email" {
  source = "./modules/pagerduty-service-orchestration"

  pagerduty_token = var.pagerduty_token

  service_id = pagerduty_service.example_orchestration_email.id

  rules = [
    # EventBridge Email
    {
      label = null,
      conditions = [
        {
          expression = "event.custom_details.plain_body matches part '?SubscriptionArn=${module.sns_topic_eventbridge.arn}:' and event.custom_details.subject matches 'AWS Notification Message'",
        },
      ]
      actions = {
        variables = [
          {
            name  = "topic_name"
            path  = "event.custom_details.plain_body"
            type  = "regex"
            value = "^.*SubscriptionArn=(?:[^:]*:){5}([^:]*):.*$"
          },
          {
            name  = "detail_type"
            path  = "event.custom_details.plain_body"
            type  = "regex"
            value = "^.*\"detail-type\":\"([^\"]*)\".*$"
          },
          {
            name  = "message_id"
            path  = "event.custom_details.plain_body"
            type  = "regex"
            value = "^.*\"id\":\"([^\"]*)\".*$"
          },
        ]

        extractions = [
          {
            target   = "event.summary"
            template = "Email [{{variables.topic_name}}] {{variables.detail_type}}"
          },
          {
            target   = "event.dedup_key"
            template = "{{variables.message_id}}"
          },
        ]
      }
    },
  ]
}

/*
# for debug
output "service_orchestration_email_rules" {
  value = module.service_orchestration_email.rules.sets
}
*/
