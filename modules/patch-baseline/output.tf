output "patch_baseline_id" {
  description = "ID of the created patch baseline."
  value       = aws_ssm_patch_baseline.this.id
}
