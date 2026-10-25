variable "patch_group" {
  description = "Value identifying instances assigned to this patch group."
  type        = string
  default     = "fleet-patch-test"
}

variable "patch_group_tag_key" {
  description = "Tag key used to discover managed nodes for this patch group."
  type        = string
  default     = "PatchGroup"
}
