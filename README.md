# example-aws-to-pd
Example of notification from AWS to PD

## Installation

```
terraform init
```

## Usage

```
terraform plan
terraform apply
```

### "Event Orchestration Action" needs to be edit manualy

- Go to output `global_orchestration_cw_alarm_html_url`
- Select the target Route and edit it with the visual editor

## Trigger

```
# CloudWatch metric alarm
terraform apply -auto-approve -var "trigger_list_bucket_call_count=true"

# EventBridge
terraform apply -auto-approve -var "trigger_tag_cahnge_on_recourse_value=$(date +'%Y%m%d_%H%M%S')"
```

## Destroy

```
terraform destroy
```

### "Event Orchestration" needs to be delete manualy

- Go to `https://{subdomain}.pagerduty.com/event-orchestration/`
- Execute Delete from the rightmost `...` of the target Orchestration
