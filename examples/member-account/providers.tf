terraform {
  required_version = ">= 1.6.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 7.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  dynamic "assume_role" {
    for_each = var.assume_deployment_role ? [local.deployment_role_arn] : []

    content {
      role_arn     = assume_role.value
      session_name = var.session_name
    }
  }

  default_tags {
    tags = var.tags
  }
}

provider "aws" {
  alias  = "bootstrap"
  region = var.aws_region
}

data "aws_caller_identity" "bootstrap" {
  provider = aws.bootstrap
}

data "aws_iam_session_context" "bootstrap" {
  provider = aws.bootstrap
  arn      = data.aws_caller_identity.bootstrap.arn
}
