resource "aws_iam_role" "maintenance_window" {
  name        = "${var.name_prefix}-maintenance-window"
  description = "Systems Manager maintenance-window service role."

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ssm.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}
