# example-aws-to-pd

Example of notification from AWS to PagerDuty

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.5.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.1.1 |
| <a name="requirement_pagerduty"></a> [pagerduty](#requirement\_pagerduty) | ~> 2.3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.5.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |
| <a name="provider_pagerduty"></a> [pagerduty](#provider\_pagerduty) | 2.3.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_global_orchestration"></a> [global\_orchestration](#module\_global\_orchestration) | ./modules/pagerduty-global-orchestration | n/a |
| <a name="module_lambda_events_api_v2"></a> [lambda\_events\_api\_v2](#module\_lambda\_events\_api\_v2) | ./modules/lambda-send-event-to-pagerduty | n/a |
| <a name="module_lambda_global_orchestration"></a> [lambda\_global\_orchestration](#module\_lambda\_global\_orchestration) | ./modules/lambda-send-event-to-pagerduty | n/a |
| <a name="module_lambda_global_ruleset"></a> [lambda\_global\_ruleset](#module\_lambda\_global\_ruleset) | ./modules/lambda-send-event-to-pagerduty | n/a |
| <a name="module_pagerduty_service_integration_custom_event_transfer"></a> [pagerduty\_service\_integration\_custom\_event\_transfer](#module\_pagerduty\_service\_integration\_custom\_event\_transfer) | ./modules/pagerduty-service-custom-event-transfer | n/a |
| <a name="module_pagerduty_service_integration_custom_event_transfer_sns"></a> [pagerduty\_service\_integration\_custom\_event\_transfer\_sns](#module\_pagerduty\_service\_integration\_custom\_event\_transfer\_sns) | ./modules/pagerduty-service-custom-event-transfer | n/a |
| <a name="module_pagerduty_service_integration_custom_event_transfer_v2"></a> [pagerduty\_service\_integration\_custom\_event\_transfer\_v2](#module\_pagerduty\_service\_integration\_custom\_event\_transfer\_v2) | ./modules/pagerduty-service-custom-event-transfer | n/a |
| <a name="module_service_orchestration"></a> [service\_orchestration](#module\_service\_orchestration) | ./modules/pagerduty-service-orchestration | n/a |
| <a name="module_service_orchestration_email"></a> [service\_orchestration\_email](#module\_service\_orchestration\_email) | ./modules/pagerduty-service-orchestration | n/a |
| <a name="module_sns_topic_cw_alarm"></a> [sns\_topic\_cw\_alarm](#module\_sns\_topic\_cw\_alarm) | ./modules/sns-topic-with-service | n/a |
| <a name="module_sns_topic_eventbridge"></a> [sns\_topic\_eventbridge](#module\_sns\_topic\_eventbridge) | ./modules/sns-topic-with-service | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_metric_alarm.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_lambda_permission.lambda_events_api_v2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.lambda_global_orchestration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.lambda_global_ruleset](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_accelerate_configuration.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_accelerate_configuration) | resource |
| [aws_s3_bucket_acl.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_intelligent_tiering_configuration.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration) | resource |
| [aws_s3_bucket_inventory.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_inventory) | resource |
| [aws_s3_bucket_lifecycle_configuration.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_ownership_controls.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_public_access_block.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_request_payment_configuration.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_request_payment_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_sns_topic_subscription.cw_alarm_to_global_orchestration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.cw_alarm_to_global_ruleset](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.cw_alarm_to_service_integration_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.eventbridge_to_global_orchestration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.eventbridge_to_global_orchestration_email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.eventbridge_to_global_orchestration_email_json](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.eventbridge_to_global_orchestration_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.eventbridge_to_global_ruleset](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.eventbridge_to_global_ruleset_email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.eventbridge_to_global_ruleset_email_json](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.eventbridge_to_global_ruleset_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.eventbridge_to_integration_custom_event_transfer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.eventbridge_to_integration_custom_event_transfer_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.eventbridge_to_integration_custom_event_transfer_v2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.eventbridge_to_integration_email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.eventbridge_to_integration_email_json](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.eventbridge_to_integration_events_api_v2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [null_resource.list_bucket_call_count](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [pagerduty_ruleset_rule.global_cw_alarm](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/ruleset_rule) | resource |
| [pagerduty_ruleset_rule.global_eventbridge](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/ruleset_rule) | resource |
| [pagerduty_ruleset_rule.global_eventbridge_email](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/ruleset_rule) | resource |
| [pagerduty_ruleset_rule.global_eventbridge_email_json](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/ruleset_rule) | resource |
| [pagerduty_ruleset_rule.global_eventbridge_lambda](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/ruleset_rule) | resource |
| [pagerduty_service.example](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service) | resource |
| [pagerduty_service.example_orchestration](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service) | resource |
| [pagerduty_service.example_orchestration_email](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service) | resource |
| [pagerduty_service.example_rulesets](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service) | resource |
| [pagerduty_service.example_rulesets_email](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service) | resource |
| [pagerduty_service_integration.cloudwatch](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service_integration) | resource |
| [pagerduty_service_integration.email](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service_integration) | resource |
| [pagerduty_service_integration.email_json](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service_integration) | resource |
| [pagerduty_service_integration.events_api_v2](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service_integration) | resource |
| [random_string.email](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.email_json](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [pagerduty_escalation_policy.example](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/data-sources/escalation_policy) | data source |
| [pagerduty_ruleset.global](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/data-sources/ruleset) | data source |
| [pagerduty_vendor.cloudwatch](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/data-sources/vendor) | data source |
| [pagerduty_vendor.email](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/data-sources/vendor) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_elable_subscription"></a> [elable\_subscription](#input\_elable\_subscription) | Enable notifications to PagerDuty. | `bool` | `false` | no |
| <a name="input_elable_subscriptions"></a> [elable\_subscriptions](#input\_elable\_subscriptions) | Enable notifications to PagerDuty. | `map(bool)` | <pre>{<br>  "cw_alarm_to_global_orchestration": false,<br>  "cw_alarm_to_global_ruleset": false,<br>  "cw_alarm_to_service_integration_cloudwatch": false,<br>  "eventbridge_to_global_orchestration": false,<br>  "eventbridge_to_global_orchestration_email": false,<br>  "eventbridge_to_global_orchestration_email_json": false,<br>  "eventbridge_to_global_orchestration_lambda": false,<br>  "eventbridge_to_global_ruleset": false,<br>  "eventbridge_to_global_ruleset_email": false,<br>  "eventbridge_to_global_ruleset_email_json": false,<br>  "eventbridge_to_global_ruleset_lambda": false,<br>  "eventbridge_to_integration_custom_event_transfer": false,<br>  "eventbridge_to_integration_custom_event_transfer_sns": false,<br>  "eventbridge_to_integration_custom_event_transfer_v2": false,<br>  "eventbridge_to_integration_email": false,<br>  "eventbridge_to_integration_email_json": false,<br>  "eventbridge_to_integration_events_api_v2": false<br>}</pre> | no |
| <a name="input_pagerduty_escalation_policy_name"></a> [pagerduty\_escalation\_policy\_name](#input\_pagerduty\_escalation\_policy\_name) | The name to use to find an escalation policy. | `string` | `"Default"` | no |
| <a name="input_pagerduty_global_integration_url"></a> [pagerduty\_global\_integration\_url](#input\_pagerduty\_global\_integration\_url) | The endpoint is generally used for integrations that have an inbuilt event transformer on pagerduty side.<br>- ref. [Amazon CloudWatch Integration Guide](https://support.pagerduty.com/docs/aws-cloudwatch-integration-guide) | `string` | `"https://events.pagerduty.com/x-ere/"` | no |
| <a name="input_pagerduty_service_integration_url"></a> [pagerduty\_service\_integration\_url](#input\_pagerduty\_service\_integration\_url) | To configure an event, please use the integration\_key in the following interpolation.<br>- ref. [Amazon CloudWatch Integration Guide](https://support.pagerduty.com/docs/aws-cloudwatch-integration-guide) | `string` | `"https://events.pagerduty.com/integration/"` | no |
| <a name="input_pagerduty_service_integration_url_slug"></a> [pagerduty\_service\_integration\_url\_slug](#input\_pagerduty\_service\_integration\_url\_slug) | To configure an event, please use the integration\_key in the following interpolation.<br>- ref. [Amazon CloudWatch Integration Guide](https://support.pagerduty.com/docs/aws-cloudwatch-integration-guide) | `string` | `"/enqueue"` | no |
| <a name="input_pagerduty_token"></a> [pagerduty\_token](#input\_pagerduty\_token) | The authorization token. | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Name to be used on all resources as prefix | `string` | `"example-aws-to-pd"` | no |
| <a name="input_trigger_list_bucket_call_count"></a> [trigger\_list\_bucket\_call\_count](#input\_trigger\_list\_bucket\_call\_count) | n/a | `bool` | `false` | no |
| <a name="input_trigger_tag_cahnge_on_recourse_value"></a> [trigger\_tag\_cahnge\_on\_recourse\_value](#input\_trigger\_tag\_cahnge\_on\_recourse\_value) | n/a | `string` | `"none"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_account_id"></a> [aws\_account\_id](#output\_aws\_account\_id) | n/a |
| <a name="output_aws_region"></a> [aws\_region](#output\_aws\_region) | n/a |
| <a name="output_global_orchestration_html_url"></a> [global\_orchestration\_html\_url](#output\_global\_orchestration\_html\_url) | n/a |
| <a name="output_pagerduty_html_url"></a> [pagerduty\_html\_url](#output\_pagerduty\_html\_url) | n/a |
