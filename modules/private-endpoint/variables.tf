variable "name" {
  description = "Private endpoint name"
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

variable "subnet_id" {
  description = "Subnet ID for the private endpoint NIC"
  type        = string
}

variable "private_connection_resource_id" {
  description = "Target resource ID (Storage, Key Vault, etc.)"
  type        = string
}

variable "subresource_names" {
  description = "Subresource names (e.g. [\"blob\"], [\"vault\"])"
  type        = list(string)
}

variable "private_dns_zone_ids" {
  description = "Private DNS zone IDs to attach via zone group"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}