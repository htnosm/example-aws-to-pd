##########
# Amazon Cloudwatch
##########
data "pagerduty_vendor" "cloudwatch" {
  name = "Amazon Cloudwatch"
}

resource "pagerduty_service_integration" "cloudwatch" {
  service = pagerduty_service.example.id
  name    = data.pagerduty_vendor.cloudwatch.name
  vendor  = data.pagerduty_vendor.cloudwatch.id
}

##########
# Email
##########
data "pagerduty_vendor" "email" {
  name = "Email"
}

# integration_email is the unique fully-qualified email address used for routing emails to this integration for processing.
resource "random_string" "email" {
  length  = 8
  special = false
  upper   = false
  lower   = true
  number  = true
}

resource "pagerduty_service_integration" "email" {
  service           = pagerduty_service.example.id
  name              = data.pagerduty_vendor.email.name
  vendor            = data.pagerduty_vendor.email.id
  integration_email = "${pagerduty_service.example.name}-email.${random_string.email.result}@${local.pagerduty_email_domain}"
}

# integration_email is the unique fully-qualified email address used for routing emails to this integration for processing.
resource "random_string" "email_json" {
  length  = 8
  special = false
  upper   = false
  lower   = true
  number  = true
}

resource "pagerduty_service_integration" "email_json" {
  service           = pagerduty_service.example.id
  name              = "${data.pagerduty_vendor.email.name}(JSON)"
  vendor            = data.pagerduty_vendor.email.id
  integration_email = "${pagerduty_service.example.name}-email.${random_string.email_json.result}@${local.pagerduty_email_domain}"
}

##########
# Custom Event Transformer
##########
module "pagerduty_service_integration_custom_event_transfer" {
  source          = "./modules/pagerduty-service-custom-event-transfer"
  service_id      = pagerduty_service.example.id
  pagerduty_token = var.pagerduty_token
  debug_mode      = true
}

module "pagerduty_service_integration_custom_event_transfer_v2" {
  source           = "./modules/pagerduty-service-custom-event-transfer"
  service_id       = pagerduty_service.example.id
  pagerduty_token  = var.pagerduty_token
  debug_mode       = true
  integration_name = "Custom Event Transformer(v2)"
  source_code_path = "modules/pagerduty-service-custom-event-transfer/templates/default.v2.js"
}

module "pagerduty_service_integration_custom_event_transfer_sns" {
  source           = "./modules/pagerduty-service-custom-event-transfer"
  service_id       = pagerduty_service.example.id
  pagerduty_token  = var.pagerduty_token
  debug_mode       = true
  integration_name = "Custom Event Transformer(SNS)"
  source_code_path = "modules/pagerduty-service-custom-event-transfer/templates/amazon_sns.js"
}

##########
# Events API v2
##########
resource "pagerduty_service_integration" "events_api_v2" {
  service = pagerduty_service.example.id
  name    = "Events API v2"
  type    = "events_api_v2_inbound_integration"
}
