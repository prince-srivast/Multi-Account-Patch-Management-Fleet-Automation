locals {
  module_name_prefix  = var.name_prefix
  target_account_id   = data.aws_caller_identity.bootstrap.account_id
  aws_partition       = split(":", data.aws_caller_identity.bootstrap.arn)[1]
  deployment_role_arn = "arn:${local.aws_partition}:iam::${local.target_account_id}:role/${var.name_prefix}-deployment"
}
