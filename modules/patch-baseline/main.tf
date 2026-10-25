resource "aws_ssm_patch_baseline" "this" {
  name             = "${var.name_prefix}-${var.patch_group}"
  operating_system = var.operating_system
  description      = "Patch baseline for patch group ${var.patch_group}."
  tags             = var.tags

  approval_rule {
    approve_after_days = var.approval_delay_days

    dynamic "patch_filter" {
      for_each = var.patch_filters
      content {
        key    = patch_filter.value.key
        values = patch_filter.value.values
      }
    }
  }
}

resource "aws_ssm_patch_group" "this" {
  baseline_id = aws_ssm_patch_baseline.this.id
  patch_group = var.patch_group
}
