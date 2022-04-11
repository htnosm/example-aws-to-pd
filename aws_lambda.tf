module "lambda_events_api_v2" {
  source          = "./modules/lambda-send-event-to-pagerduty"
  name            = "${var.resource_prefix}-events-api-v2"
  integration_key = pagerduty_service_integration.events_api_v2.integration_key
}

resource "aws_lambda_permission" "lambda_events_api_v2" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_events_api_v2.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = module.sns_topic_eventbridge.arn
}

module "lambda_global_ruleset" {
  source          = "./modules/lambda-send-event-to-pagerduty"
  name            = "${var.resource_prefix}-ruleset"
  integration_key = data.pagerduty_ruleset.global.routing_keys[0]
}

resource "aws_lambda_permission" "lambda_global_ruleset" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_global_ruleset.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = module.sns_topic_eventbridge.arn
}

module "lambda_global_orchestration" {
  source          = "./modules/lambda-send-event-to-pagerduty"
  name            = "${var.resource_prefix}-orchestration"
  integration_key = module.global_orchestration.result.integration_key
}

resource "aws_lambda_permission" "lambda_global_orchestration" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_global_orchestration.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = module.sns_topic_eventbridge.arn
}
