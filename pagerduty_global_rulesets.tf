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
