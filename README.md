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

### trigger

```
# CloudWatch metric alarm
terraform apply -auto-approve -var "trigger_list_bucket_call_count=true"

# EventBridge
terraform apply -auto-approve -var "trigger_tag_cahnge_on_recourse_value=$(date +'%Y%m%d_%H%M%S')"
```
