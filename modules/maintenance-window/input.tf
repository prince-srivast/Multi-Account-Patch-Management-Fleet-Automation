variable "name_prefix" {
  description = "Prefix used for maintenance window and task names."
  type        = string
}

variable "patch_group" {
  description = "Patch-group value used to select managed nodes."
  type        = string
}

variable "patch_group_tag_key" {
  description = "Instance tag key used to select managed nodes."
  type        = string
  default     = "PatchGroup"
}

variable "schedule" {
  description = "Systems Manager maintenance-window schedule expression."
  type        = string
}

variable "duration" {
  description = "Maintenance-window duration in hours."
  type        = number
  default     = 4
}

variable "cutoff" {
  description = "Hours before the end of the window when new tasks stop starting."
  type        = number
  default     = 1
}

variable "schedule_timezone" {
  description = "Timezone used to interpret the maintenance-window schedule."
  type        = string
  default     = "Etc/UTC"
}

variable "maintenance_window_role_arn" {
  description = "Existing IAM service role used by the maintenance-window task."
  type        = string
}

variable "max_concurrency" {
  description = "Maximum concurrent managed nodes, as an integer or percentage."
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

variable "priority" {
  description = "Task priority within the maintenance window; lower numbers run first."
  type        = number
  default     = 1
}

variable "timeout_seconds" {
  description = "Maximum run-command execution time in seconds."
  type        = number
  default     = 3600
}

variable "tags" {
  description = "Tags applied to the maintenance window."
  type        = map(string)
  default     = {}
}
