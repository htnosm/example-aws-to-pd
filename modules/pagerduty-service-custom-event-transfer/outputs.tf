output "integration_url" {
  value = "https://events.pagerduty.com/integration/${pagerduty_service_integration.this.integration_key}/enqueue"
}
