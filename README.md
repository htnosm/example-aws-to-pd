# example-aws-to-pd
Example of notification from AWS to PD

## Requirements

- Terraform 1.1.7+
- bash, curl

## Usage

```
terraform init

terraform plan
terraform apply

# Enable notifications to PagerDuty
# Set each element value of ${var.elable_subscriptions} to true (ref. variables.tf)
```

### Note

You need an environment that can connect to AWS and PagerDuty.

#### AWS

Add the connection information to the environment variable.

```
# e.g.
export AWS_PROFILE=""
```

#### PagerDuty

Set PagerDuty API Token to `pagerduty_token`.

```
# e.g.
cat <<EOF > terraform.tfvars
pagerduty_token = ""
EOF
```

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
