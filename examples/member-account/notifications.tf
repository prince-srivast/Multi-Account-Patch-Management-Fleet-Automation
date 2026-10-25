module "notifications" {
  source = "../../modules/notifications"

  name_prefix           = local.module_name_prefix
  maintenance_window_id = module.maintenance_window.maintenance_window_id
  email_address         = var.notification_email
  tags                  = var.tags
}
