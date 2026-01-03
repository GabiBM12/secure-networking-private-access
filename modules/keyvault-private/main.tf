resource "azurerm_key_vault" "this" {
  name                = "kv-${var.name_prefix}-core"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  # private-by-default posture
  public_network_access_enabled = false
  enable_rbac_authorization = true

  tags = var.tags
}