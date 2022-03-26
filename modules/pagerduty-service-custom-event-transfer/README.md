# pagerduty-service-custom-event-transfer

Create a "Custom Event Transformer" in PargerDuty Service.

`pagerduty_service_integration` does not support advanced options, so it execute PagerDuty API.
- ref.
  - [API Reference \| PagerDuty Developer Documentation](https://developer.pagerduty.com/api-reference)
  - (similar issue) [\[Feature Request\] Allow pagerduty\\_service\\_integration to modify CloudWatch "Correlate events by" and "Derive name from" options · Issue \#260 · PagerDuty/terraform\-provider\-pagerduty · GitHub](https://github.com/PagerDuty/terraform-provider-pagerduty/issues/260)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.1 |
| <a name="requirement_pagerduty"></a> [pagerduty](#requirement\_pagerduty) | ~> 2.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | ~> 3.1 |
| <a name="provider_pagerduty"></a> [pagerduty](#provider\_pagerduty) | ~> 2.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.pagerduty_service_integration_config](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [pagerduty_service_integration.this](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service_integration) | resource |
| [pagerduty_vendor.custom_event_transformer](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/data-sources/vendor) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_debug_mode"></a> [debug\_mode](#input\_debug\_mode) | Debug mode (send an event to your service if code produces errors). | `bool` | `true` | no |
| <a name="input_integration_name"></a> [integration\_name](#input\_integration\_name) | The name of the service integration. | `string` | `"Custom Event Transformer"` | no |
| <a name="input_pagerduty_token"></a> [pagerduty\_token](#input\_pagerduty\_token) | The v2 authorization token. | `string` | n/a | yes |
| <a name="input_service_id"></a> [service\_id](#input\_service\_id) | The ID of the service the integration should belong to. | `string` | n/a | yes |
| <a name="input_source_code_path"></a> [source\_code\_path](#input\_source\_code\_path) | path to the function's source code within the local filesystem. (Do not use single quotes in the source.) | `string` | `"default.js"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_integration_url"></a> [integration\_url](#output\_integration\_url) | n/a |
