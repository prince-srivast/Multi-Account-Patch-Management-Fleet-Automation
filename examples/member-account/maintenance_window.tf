module "maintenance_window" {
  source = "../../modules/maintenance-window"

  name_prefix                 = local.module_name_prefix
  patch_group                 = var.patch_group
  patch_group_tag_key         = var.patch_group_tag_key
  schedule                    = var.maintenance_window_schedule
  duration                    = var.maintenance_window_duration
  cutoff                      = var.cutoff
  maintenance_window_role_arn = var.maintenance_window_role_arn
  max_concurrency             = var.max_concurrency
  max_errors                  = var.max_errors
  reboot_option               = var.reboot_option
  tags                        = var.tags
}
