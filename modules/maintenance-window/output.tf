output "maintenance_window_id" {
  description = "ID of the created maintenance window."
  value       = aws_ssm_maintenance_window.this.id
}

output "maintenance_window_target_id" {
  description = "ID of the maintenance-window target."
  value       = aws_ssm_maintenance_window_target.this.id
}
