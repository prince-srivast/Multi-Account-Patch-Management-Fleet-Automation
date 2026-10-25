variable "name_prefix" {
  description = "Prefix used for the patch baseline name."
  type        = string
}

variable "operating_system" {
  description = "Operating-system family accepted by Systems Manager Patch Manager."
  type        = string
}

variable "patch_group" {
  description = "Patch-group name associated with this baseline."
  type        = string
}

variable "patch_filters" {
  description = "Patch filters for the baseline approval rule."
  type = list(object({
    key    = string
    values = list(string)
  }))

  validation {
    condition     = length(var.patch_filters) > 0 && alltrue([for filter in var.patch_filters : length(filter.values) > 0])
    error_message = "Provide at least one patch filter, and at least one value for each filter."
  }
}

variable "approval_delay_days" {
  description = "Days to wait after release before approving matching patches."
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags applied to the patch baseline."
  type        = map(string)
  default     = {}
}
