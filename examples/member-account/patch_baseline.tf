module "patch_baseline" {
  source = "../../modules/patch-baseline"

  name_prefix         = local.module_name_prefix
  operating_system    = var.operating_system
  patch_group         = var.patch_group
  patch_filters       = var.patch_filters
  approval_delay_days = var.approval_delay_days
  tags                = var.tags
}
