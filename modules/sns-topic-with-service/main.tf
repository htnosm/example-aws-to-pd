/**
 * # sns-topic-with-service
 *
 * Resources:
 *  - SNS Topic
 *  - SNS Topic Policy
 */

terraform {
  required_providers {
    aws = {}
  }
}

data "aws_caller_identity" "current" {}

resource "aws_sns_topic" "this" {
  name = var.name
  tags = merge(var.tags,
    {
      Name = var.name
    }
  )
}

resource "aws_sns_topic_policy" "this" {
  arn    = aws_sns_topic.this.arn
  policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  statement {
    sid = "__default_statement_ID"

    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:Receive",
    ]

    effect = "Allow"

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        "${data.aws_caller_identity.current.account_id}",
      ]
    }

    resources = [
      aws_sns_topic.this.arn,
    ]
  }

  dynamic "statement" {
    for_each = length(var.identifiers) == 0 ? [] : [var.identifiers]

    content {
      actions = ["SNS:Publish"]
      effect  = "Allow"
      principals {
        identifiers = statement.value
        type        = "Service"
      }
      resources = [aws_sns_topic.this.arn]
    }
  }
}
