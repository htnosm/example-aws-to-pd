data "pagerduty_ruleset" "global" {
  name = "Default Global"
}

# "Default Global Ruleset" does not have a slug "_default"
locals {
  ruleset_slug = "_default"
}

resource "pagerduty_ruleset_rule" "global_cw_alarm" {
  ruleset  = local.ruleset_slug
  disabled = "false"
  position = 0

  conditions {
    operator = "and"
    subconditions {
      operator = "equals"
      parameter {
        path  = "TopicArn"
        value = module.sns_topic_cw_alarm.arn
      }
    }
  }

  actions {
    route {
      value = pagerduty_service.example_rulesets.id
    }
    severity {
      value = "info"
    }
  }
}

resource "pagerduty_ruleset_rule" "global_eventbridge" {
  ruleset  = local.ruleset_slug
  disabled = "false"
  position = 1

  conditions {
    operator = "and"
    subconditions {
      operator = "equals"
      parameter {
        path  = "TopicArn"
        value = module.sns_topic_eventbridge.arn
      }
    }
  }

  actions {
    route {
      value = pagerduty_service.example_rulesets.id
    }
    severity {
      value = "info"
    }

    extractions {
      target   = "summary"
      template = "{{topic_name}}: {{detail_type}}"
    }
    extractions {
      target   = "dedup_key"
      template = "{{message_id}}"
    }
  }

  variable {
    name = "topic_name"
    type = "regex"

    parameters {
      path  = "TopicArn"
      value = "^.*:(.*)"
    }
  }
  variable {
    name = "detail_type"
    type = "regex"

    parameters {
      path  = "Message"
      value = "^.*\"detail-type\":\"([^\"]*)\".*$"
    }
  }
  variable {
    name = "message_id"
    type = "regex"

    parameters {
      path  = "MessageId"
      value = "(.*)"
    }
  }
}
