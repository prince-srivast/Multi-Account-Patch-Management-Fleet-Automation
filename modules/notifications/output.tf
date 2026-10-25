output "topic_arn" {
  description = "ARN of the SNS topic receiving maintenance-window events."
  value       = aws_sns_topic.this.arn
}

output "event_rule_arn" {
  description = "ARN of the EventBridge maintenance-window rule."
  value       = aws_cloudwatch_event_rule.maintenance_window.arn
}
