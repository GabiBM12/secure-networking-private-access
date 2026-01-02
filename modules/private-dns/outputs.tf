output "private_dns_zone_ids" {
  description = "Private DNS zone IDs keyed by zone key"
  value = {
    for key, zone in azurerm_private_dns_zone.this :
    key => zone.id
  }
}

output "private_dns_zone_names" {
  description = "Private DNS zone names keyed by zone key"
  value = {
    for key, zone in azurerm_private_dns_zone.this :
    key => zone.name
  }
}