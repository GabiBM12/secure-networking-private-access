locals {
  name_prefix = "${var.project_name}-${var.environment}"

  tags = merge(
    var.tags,
    {
      project     = var.project_name
      environment = var.environment
      managed_by  = "terraform"
      repo        = "repo-02"
    }
  )
}

module "rg" {
  source = "../../modules/resource-group"

  name     = "rg-${local.name_prefix}-core"
  location = var.location
  tags     = local.tags
}

module "network" {
  source = "../../modules/network-core"

  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = module.rg.name

  vnet_address_space = ["10.0.0.0/16"]

  subnets = {
    snet-workloads = {
      address_prefixes = ["10.0.2.0/24"]
    }
    snet-private-endpoints = {
      address_prefixes = ["10.0.1.0/24"]
    }
    snet-container-apps = {
      address_prefixes = ["10.0.3.0/26"]

      delegation = {
        name = "delegation-container-apps"
        service_delegation = {
          name    = "Microsoft.App/environments"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
  }

  tags = local.tags
}

module "private_dns" {
  source = "../../modules/private-dns"

  resource_group_name = module.rg.name
  location            = var.location
  vnet_id             = module.network.vnet_id

  dns_zones = {
    blob     = "privatelink.blob.core.windows.net"
    keyvault = "privatelink.vaultcore.azure.net"
  }

  tags = local.tags
}

data "azurerm_client_config" "current" {}

module "storage" {
  source = "../../modules/storage-private"

  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = module.rg.name
  tags                = local.tags
}

module "keyvault" {
  source = "../../modules/keyvault-private"

  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = module.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = local.tags
}

locals {
  pe_subnet_id = module.network.subnet_ids["snet-private-endpoints"]
}

module "pe_storage_blob" {
  source = "../../modules/private-endpoint"

  name                = "pe-${local.name_prefix}-st-blob"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = local.pe_subnet_id

  private_connection_resource_id = module.storage.id
  subresource_names              = ["blob"]

  private_dns_zone_ids = [
    module.private_dns.private_dns_zone_ids["blob"]
  ]

  tags = local.tags
}

module "pe_keyvault" {
  source = "../../modules/private-endpoint"

  name                = "pe-${local.name_prefix}-kv"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = local.pe_subnet_id

  private_connection_resource_id = module.keyvault.id
  subresource_names              = ["vault"]

  private_dns_zone_ids = [
    module.private_dns.private_dns_zone_ids["keyvault"]
  ]

  tags = local.tags
}

module "rbac" {
  source = "../../modules/iam-rbac"

  assignments = {
    # For verification/testing: grant your current identity access.
    # You can later replace this with managed identities from workloads.
    me_kv_secrets_officer = {
      scope                = module.keyvault.id
      role_definition_name = "Key Vault Secrets Officer"
      principal_id         = data.azurerm_client_config.current.object_id
    }

    me_storage_blob_contributor = {
      scope                = module.storage.id
      role_definition_name = "Storage Blob Data Contributor"
      principal_id         = data.azurerm_client_config.current.object_id
    }
  }
}

module "policy" {
  source = "../../modules/policy-guardrails"
  RG_id  = module.rg.id

  assignments = {
    kv_disable_public_access = {
      display_name         = "Guardrail: Key Vault public network access disabled"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/405c5871-3e91-4644-8a63-58e19d68ff5b"
    }

    storage_disable_public_access = {
      display_name         = "Guardrail: Storage public network access disabled"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b2982f36-99f2-4db5-8eff-283140c09693"
    }
  }
}