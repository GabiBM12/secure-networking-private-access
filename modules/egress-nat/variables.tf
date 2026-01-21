variable "name_prefix" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "subnet_ids" { type = list(string) } # subnets that need egress
variable "tags" { type = map(string) }