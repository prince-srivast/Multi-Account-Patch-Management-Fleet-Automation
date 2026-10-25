resource "aws_sns_topic" "this" {
  name = "${var.name_prefix}-maintenance-events"
  tags = var.tags
}

resource "aws_sns_topic_policy" "this" {
  arn = aws_sns_topic.this.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "AllowEventBridgePublish"
      Effect    = "Allow"
      Principal = { Service = "events.amazonaws.com" }
      Action    = "sns:Publish"
      Resource  = aws_sns_topic.this.arn
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_cloudwatch_event_rule.maintenance_window.arn
        }
      }
    }]
  })
}

resource "aws_cloudwatch_event_rule" "maintenance_window" {
  name        = "${var.name_prefix}-maintenance-window-events"
  description = "Maintenance-window state changes for ${var.maintenance_window_id}."

  event_pattern = jsonencode({
    source        = ["aws.ssm"]
    "detail-type" = ["Maintenance Window Execution State-change Notification"]
    detail = {
      "window-id" = [var.maintenance_window_id]
    }
  })

  tags = var.tags
}

resource "aws_cloudwatch_event_target" "sns" {
  rule       = aws_cloudwatch_event_rule.maintenance_window.name
  target_id  = "maintenance-events-sns"
  arn        = aws_sns_topic.this.arn
  depends_on = [aws_sns_topic_policy.this]
}

resource "aws_sns_topic_subscription" "email" {
  count     = var.email_address == "" ? 0 : 1
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.email_address
}
