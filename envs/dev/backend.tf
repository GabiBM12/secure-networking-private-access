terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "gabibtfstate0012"
    container_name       = "tfstate"
    key                  = "secure-networking-private-acces/dev.tfstate"

    use_oidc = true
    use_azuread_auth = true
  }
}