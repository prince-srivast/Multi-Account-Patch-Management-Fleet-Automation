module "iam" {
  source = "../../modules/iam"

  name_prefix                 = var.name_prefix
  deployment_trusted_role_arn = data.aws_iam_session_context.bootstrap.issuer_arn
  tags                        = var.tags
}
