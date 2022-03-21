data "pagerduty_vendor" "cloudwatch" {
  name = "Amazon Cloudwatch"
}

resource "pagerduty_service_integration" "cloudwatch" {
  service = pagerduty_service.example.id
  name    = data.pagerduty_vendor.cloudwatch.name
  vendor  = data.pagerduty_vendor.cloudwatch.id
}

