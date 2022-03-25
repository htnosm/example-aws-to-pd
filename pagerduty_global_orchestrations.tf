module "global_orchestration_cw_alarm" {
  source = "./modules/pagerduty-global-orchestration"

  pagerduty_token = var.pagerduty_token

  name        = "${var.resource_prefix}-cw-alarm"
  description = "Managed by Terraform"

  rules = [
    {
      label = null,
      conditions = [
        {
          expression = "raw_event.TopicArn matches '${module.sns_topic_cw_alarm.arn}'",
        }
      ]
      actions = {
        route_to = pagerduty_service.example_orchestration.id
      }
    },
  ]
}

output "global_orchestration_cw_alarm_html_url" {
  value = module.global_orchestration_cw_alarm.result.html_url
}
