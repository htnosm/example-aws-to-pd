resource "aws_cloudwatch_metric_alarm" "example" {
  alarm_name          = "${var.resource_prefix}-list-bucket-call-count"
  alarm_description   = "This metric monitors list bucket call count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  metric_name         = "CallCount"
  namespace           = "AWS/Usage"
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  treat_missing_data  = "notBreaching"

  dimensions = {
    Type     = "API"
    Resource = "ListBuckets"
    Service  = "S3"
    Class    = "None"
  }

  alarm_actions = [
    module.sns_topic_cw_alarm.arn
  ]
  ok_actions = [
    module.sns_topic_cw_alarm.arn
  ]
  insufficient_data_actions = []
}

# EventBridge
resource "aws_cloudwatch_event_rule" "example" {
  name        = "${var.resource_prefix}-tag-cahnge-on-recourse"
  description = "Capture Tag Change on Resource"

  event_pattern = jsonencode({
    source        = ["aws.tag"]
    "detail-type" = ["Tag Change on Resource"]
    resources     = [aws_s3_bucket.example.arn]
  })
}

resource "aws_cloudwatch_event_target" "example" {
  rule = aws_cloudwatch_event_rule.example.name
  arn  = module.sns_topic_eventbridge.arn
}
