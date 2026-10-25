resource "aws_ssm_maintenance_window" "this" {
  name                       = "${var.name_prefix}-${var.patch_group}"
  description                = "Scheduled patching window for patch group ${var.patch_group}."
  schedule                   = var.schedule
  duration                   = var.duration
  cutoff                     = var.cutoff
  allow_unassociated_targets = false
  enabled                    = true
  schedule_timezone          = var.schedule_timezone
  tags                       = var.tags
}

resource "aws_ssm_maintenance_window_target" "this" {
  window_id     = aws_ssm_maintenance_window.this.id
  name          = "${var.name_prefix}-${var.patch_group}"
  description   = "Instances with ${var.patch_group_tag_key}=${var.patch_group}."
  resource_type = "INSTANCE"

  targets {
    key    = "tag:${var.patch_group_tag_key}"
    values = [var.patch_group]
  }
}

resource "aws_ssm_maintenance_window_task" "this" {
  window_id        = aws_ssm_maintenance_window.this.id
  name             = "${var.name_prefix}-${var.patch_group}"
  description      = "Install approved patches for ${var.patch_group}."
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  priority         = var.priority
  service_role_arn = var.maintenance_window_role_arn
  max_concurrency  = var.max_concurrency
  max_errors       = var.max_errors

  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.this.id]
  }

  task_invocation_parameters {
    run_command_parameters {
      timeout_seconds = var.timeout_seconds

      parameter {
        name   = "Operation"
        values = ["Install"]
      }

      parameter {
        name   = "RebootOption"
        values = [var.reboot_option]
      }
    }
  }
}
