variable "aws_region" {
  description = "AWS Region containing the managed instances and patch resources."
  type        = string
}

variable "deployment_role_arn" {
  description = "Existing role assumed by Terraform in the target account."
  type        = string
}

variable "session_name" {
  description = "STS session name used when assuming the deployment role."
  type        = string
  default     = "fleet-patch-deployment"
}

variable "operating_system" {
  description = "Operating-system family for the patch baseline."
  type        = string
  default     = "AMAZON_LINUX_2"
}

variable "patch_group" {
  description = "Value identifying instances assigned to this patch group."
  type        = string
}

variable "patch_group_tag_key" {
  description = "Tag key used to discover managed nodes for this patch group."
  type        = string
  default     = "PatchGroup"
}

variable "patch_filters" {
  description = "Patch filters in the approval rule."
  type = list(object({
    key    = string
    values = list(string)
  }))
  default = [{
    key    = "CLASSIFICATION"
    values = ["Security", "Bugfix"]
  }]
}

variable "approval_delay_days" {
  description = "Days after release before matching patches are approved."
  type        = number
  default     = 7

  validation {
    condition     = var.approval_delay_days >= 0 && var.approval_delay_days <= 360
    error_message = "approval_delay_days must be between 0 and 360."
  }
}

variable "maintenance_window_schedule" {
  description = "Systems Manager maintenance-window schedule expression."
  type        = string
  default     = "cron(0 3 ? * SUN *)"
}

variable "maintenance_window_duration" {
  description = "Maintenance-window duration in hours."
  type        = number
  default     = 4
}

variable "cutoff" {
  description = "Hours before the window ends when new tasks stop starting."
  type        = number
  default     = 1
}

variable "maintenance_window_role_arn" {
  description = "Existing IAM service role used by the maintenance-window task."
  type        = string
}

variable "max_concurrency" {
  description = "Maximum managed nodes patched concurrently."
  type        = string
  default     = "10%"
}

variable "max_errors" {
  description = "Maximum task errors before Systems Manager stops execution."
  type        = string
  default     = "1"
}

variable "reboot_option" {
  description = "Reboot behavior for AWS-RunPatchBaseline."
  type        = string
  default     = "RebootIfNeeded"

  validation {
    condition     = contains(["RebootIfNeeded", "NoReboot"], var.reboot_option)
    error_message = "reboot_option must be RebootIfNeeded or NoReboot."
  }
}

variable "notification_email" {
  description = "Optional SNS email endpoint; recipient must confirm the subscription."
  type        = string
  default     = ""
}

variable "name_prefix" {
  description = "Prefix for created AWS resource names."
  type        = string
  default     = "fleet-patch"
}

variable "tags" {
  description = "Tags applied to created resources."
  type        = map(string)
  default     = {}
}
