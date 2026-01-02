variable "resource_group_name" {
  description = "Resource group for Private DNS zones"
  type        = string
}

variable "location" {
  description = "Azure region (required by provider, not used by DNS zones)"
  type        = string
}

variable "vnet_id" {
  description = "ID of the VNet to link Private DNS zones to"
  type        = string
}

variable "dns_zones" {
  description = "Map of Private DNS zones to create"
  type        = map(string)
}

variable "tags" {
  description = "Tags applied to taggable resources"
  type        = map(string)
  default     = {}
}