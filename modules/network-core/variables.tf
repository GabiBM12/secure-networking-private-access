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

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
}

variable "tags" {
  description = "Tags for taggable resources"
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "Subnet map keyed by subnet name"
  type = map(object({
    address_prefixes = list(string)

    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }))
  }))
}