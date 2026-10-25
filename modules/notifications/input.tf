variable "name_prefix" {
  description = "Prefix used for resource names."
  type        = string
}

variable "maintenance_window_id" {
  description = "Systems Manager maintenance-window ID to match in EventBridge."
  type        = string
}

variable "email_address" {
  description = "Optional email subscription endpoint for the SNS topic."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags applied to created resources."
  type        = map(string)
  default     = {}
}
