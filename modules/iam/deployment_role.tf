resource "aws_iam_role" "deployment" {
  name        = "${var.name_prefix}-deployment"
  description = "Terraform deployment role for patch-management resources."

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = var.deployment_trusted_role_arn
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}
