/**
 * # lambda-send-event-to-pagerduty
 *
 * Send an Alert Event to PagerDuty
 */

data "aws_iam_policy_document" "this_assume_role_policy" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [
        "lambda.amazonaws.com",
      ]
      type = "Service"
    }
    actions = [
      "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.this_assume_role_policy.json
  tags = {
    Name = var.name
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_role" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "this" {
  type        = "zip"
  source_dir  = "${path.module}/functions/send-event-to-pagerduty"
  output_path = "${path.module}/functions/uploads/${var.name}.zip"
}

resource "aws_lambda_function" "this" {
  filename         = data.archive_file.this.output_path
  function_name    = var.name
  role             = aws_iam_role.this.arn
  handler          = "handler.lambda_handler"
  source_code_hash = data.archive_file.this.output_base64sha256

  runtime = var.lambda_function_runtime
  timeout = var.lambda_function_timeout
  publish = false

  environment {
    variables = {
      INTEGRATION_KEY = var.integration_key
    }
  }

  tags = {
    Name = var.name
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = var.lambda_function_log_retention_in_days
  tags = {
    Name = "/aws/lambda/${aws_lambda_function.this.function_name}"
  }
}
