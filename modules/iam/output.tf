output "deployment_role_arn" {
  description = "ARN of the Terraform deployment role."
  value       = aws_iam_role.deployment.arn
}

output "maintenance_window_role_arn" {
  description = "ARN of the Systems Manager maintenance-window service role."
  value       = aws_iam_role.maintenance_window.arn
}
