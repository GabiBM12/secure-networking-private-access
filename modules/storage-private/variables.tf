variable "name_prefix" {
  description = "Name prefix (e.g., gb-dev)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}