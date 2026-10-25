output "patch_baseline_id" {
  description = "ID of the patch baseline associated with the configured patch group."
  value       = module.patch_baseline.patch_baseline_id
}

output "maintenance_window_id" {
  description = "ID of the scheduled maintenance window."
  value       = module.maintenance_window.maintenance_window_id
}

output "deployment_role_arn" {
  description = "IAM role ARN Terraform can assume after the initial bootstrap apply."
  value       = module.iam.deployment_role_arn
}

output "maintenance_window_role_arn" {
  description = "IAM service role ARN used by the maintenance-window task."
  value       = module.iam.maintenance_window_role_arn
}

output "notification_topic_arn" {
  description = "SNS topic ARN receiving maintenance-window state-change events."
  value       = module.notifications.topic_arn
}
