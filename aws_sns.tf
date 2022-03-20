module "sns_topic_cw_alarm" {
  source = "./modules/sns-topic-with-service"

  name        = "${var.resource_prefix}-cw-alarm"
  identifiers = []
}

module "sns_topic_eventbridge" {
  source = "./modules/sns-topic-with-service"

  name        = "${var.resource_prefix}-eventbridge"
  identifiers = ["events.amazonaws.com"]
}
