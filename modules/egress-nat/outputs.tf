output "nat_public_ip" {
  value = azurerm_public_ip.nat.ip_address
}

output "nat_gateway_id" {
  value = azurerm_nat_gateway.this.id
}