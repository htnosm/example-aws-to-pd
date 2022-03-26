# pagerduty-service-custom-event-transfer

Create a "Custom Event Transformer" in PargerDuty Service.

`event_orchestrations` does not support, so it execute PagerDuty API.
- ref.
  - [API Reference \| PagerDuty Developer Documentation](https://developer.pagerduty.com/api-reference)
  - [Add support for event\\_orchestrations API · Issue \#465](https://github.com/PagerDuty/terraform-provider-pagerduty/issues/465)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_external"></a> [external](#requirement\_external) | ~> 2.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | ~> 2.2 |
| <a name="provider_null"></a> [null](#provider\_null) | ~> 3.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.rules](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.this](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [external_external.rules](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [external_external.this](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | A description of this Orchestration's purpose. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the Orchestration. | `string` | n/a | yes |
| <a name="input_pagerduty_token"></a> [pagerduty\_token](#input\_pagerduty\_token) | The authorization token. | `string` | n/a | yes |
| <a name="input_rule_id"></a> [rule\_id](#input\_rule\_id) | The ID of this set of rules. | `string` | `"start"` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | The Router evaluates Events against these Rules, one at a time, and routes each Event to a specific Service based on the first rule that matches. | <pre>list(object({<br>    label : string,<br>    conditions : list(object({<br>      expression : string<br>    })),<br>    actions : object({<br>      route_to : string<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_team_id"></a> [team\_id](#input\_team\_id) | Reference to the team that owns the Orchestration. If none is specified, only admins have access. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_result"></a> [result](#output\_result) | n/a |
| <a name="output_rules"></a> [rules](#output\_rules) | n/a |
