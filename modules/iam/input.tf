variable "name_prefix" {
  description = "Prefix used for IAM role names."
  type        = string

  validation {
    condition     = length(var.name_prefix) <= 40
    error_message = "name_prefix must be 40 characters or fewer to keep generated IAM role names within AWS limits."
  }
}

variable "deployment_trusted_role_arn" {
  description = "IAM principal ARN detected from the bootstrap AWS credentials."
  type        = string
}

variable "tags" {
  description = "Tags applied to IAM roles."
  type        = map(string)
  default     = {}
}
