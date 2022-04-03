# pagerduty-service-orchestration

Create a "Orchestration Rule" in PargerDuty Service.

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
| [external_external.rules](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pagerduty_token"></a> [pagerduty\_token](#input\_pagerduty\_token) | The authorization token. | `string` | n/a | yes |
| <a name="input_rule_id"></a> [rule\_id](#input\_rule\_id) | The ID of this set of rules. | `string` | `"start"` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | The Service Orchestration evaluates Events sent to this Service against each of its rules,<br>beginning with the rules in the "start" set.<br><br>Optional:<br>[<br>  {<br>    label = string<br>    conditions = [<br>      {<br>        expression = string,<br>      },<br>    ]<br>    actions = {<br>      route\_to           = string<br>      suppress           = bool<br>      suspend            = number<br>      priority           = string<br>      annotate           = string<br>      severity           = string<br>      event\_action       = string<br>      automation\_actions = list(object)<br>      variables          = list(object)<br>      extractions        = list(object)<br>    }<br>    disabled = bool<br>  },<br>] | `list` | `[]` | no |
| <a name="input_service_id"></a> [service\_id](#input\_service\_id) | ID of existing service. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rules"></a> [rules](#output\_rules) | n/a |
