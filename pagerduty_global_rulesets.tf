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

resource "pagerduty_ruleset_rule" "global_eventbridge_email" {
  ruleset  = local.ruleset_slug
  disabled = "false"
  position = 2

  conditions {
    operator = "and"
    subconditions {
      operator = "equals"
      parameter {
        path  = "headers.subject"
        value = "AWS Notification Message"
      }
    }
    subconditions {
      operator = "contains"
      parameter {
        path  = "body"
        value = "?SubscriptionArn=${module.sns_topic_eventbridge.arn}:"
      }
    }
  }

  actions {
    route {
      value = pagerduty_service.example_rulesets_email.id
    }

    extractions {
      target   = "summary"
      template = "Email: Tag Change on Resource"
    }
    extractions {
      target   = "dedup_key"
      template = "Email {{message_id}}"
    }
  }

  variable {
    name = "message_id"
    type = "regex"

    parameters {
      path  = "body"
      value = "^.*\"id\":\"([^\"]*)\".*$"
    }
  }
}

resource "pagerduty_ruleset_rule" "global_eventbridge_email_json" {
  ruleset  = local.ruleset_slug
  disabled = "false"
  position = 3

  conditions {
    operator = "and"
    subconditions {
      operator = "equals"
      parameter {
        path  = "headers.subject"
        value = "AWS Notification Message"
      }
    }
    subconditions {
      operator = "contains"
      parameter {
        path  = "body"
        value = "\"TopicArn\" : \"${module.sns_topic_eventbridge.arn}\""
      }
    }
  }

  actions {
    route {
      value = pagerduty_service.example_rulesets.id
    }

    extractions {
      target   = "summary"
      template = "Email-JSON: Tag Change on Resource"
    }
    extractions {
      target   = "dedup_key"
      template = "Email-JSON {{message_id}}"
    }
  }

  variable {
    name = "message_id"
    type = "regex"

    parameters {
      path  = "body"
      value = "^.*\"MessageId\" : \"([^\"]*)\".*$"
    }
  }
}

resource "pagerduty_ruleset_rule" "global_eventbridge_lambda" {
  ruleset  = local.ruleset_slug
  disabled = "false"
  position = 4

  conditions {
    operator = "and"
    subconditions {
      operator = "equals"
      parameter {
        path  = "payload.source"
        value = module.sns_topic_eventbridge.arn
      }
    }
  }

  actions {
    route {
      value = pagerduty_service.example_rulesets.id
    }
  }
}
