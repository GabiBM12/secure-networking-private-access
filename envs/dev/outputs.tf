output "resource_group_name" {
  description = "Core resource group name"
  value       = module.rg.name
}

output "resource_group_id" {
  description = "Core resource group id"
  value       = module.rg.id
}
output "vnet_name" { value = module.network.vnet_name }

output "subnet_ids" { value = module.network.subnet_ids }

output "private_dns_zone_ids" {
  value       = module.private_dns.private_dns_zone_ids
  description = "Private DNS zone IDs"
}
output "acr_id" {
  value = module.acr.id
}

output "acr_name" {
  value = module.acr.name
}

output "acr_login_server" {
  value = module.acr.login_server
}