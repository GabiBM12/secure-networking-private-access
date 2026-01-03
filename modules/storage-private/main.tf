resource "azurerm_storage_account" "this" {
  # Storage account names must be globally unique and 3-24 lowercase alphanumeric
  name                     = replace("st${var.name_prefix}core", "-", "")
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # private-by-default posture
  public_network_access_enabled = false

  # good defaults
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"

  tags = var.tags
}

#Note: replace() removes hyphens because storage names can’t contain -.