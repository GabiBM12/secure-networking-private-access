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