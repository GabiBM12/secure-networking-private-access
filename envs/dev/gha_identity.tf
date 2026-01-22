resource "azurerm_user_assigned_identity" "gha_repo2_tf" {
  name                = "uami-${local.name_prefix}-gha-tf"
  location            = var.location
  resource_group_name = module.rg.name
  tags                = local.tags
}

# Minimum practical permission for a platform repo:
# Scope it to the platform RG (where VNet, DNS, PEs, NAT, NSGs live)
resource "azurerm_role_assignment" "gha_repo2_tf_rg_contributor" {
  scope                = module.rg.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.gha_repo2_tf.principal_id
}

# OPTIONAL allow reading role assignments if needed in future
# resource "azurerm_role_assignment" "gha_repo2_tf_rg_reader" { ... }

# Federated credential: pull_request (for PLAN job on PRs)
resource "azurerm_federated_identity_credential" "gha_repo2_pr" {
  name                = "fic-repo2-pr"
  resource_group_name = module.rg.name
  parent_id           = azurerm_user_assigned_identity.gha_repo2_tf.id

  issuer   = "https://token.actions.githubusercontent.com"
  subject  = "repo:GabiBM12/secure-networking-private-access:pull_request"
  audience = ["api://AzureADTokenExchange"]
}

# Federated credential: main branch (for APPLY job on main)
resource "azurerm_federated_identity_credential" "gha_repo2_main" {
  name                = "fic-repo2-main"
  resource_group_name = module.rg.name
  parent_id           = azurerm_user_assigned_identity.gha_repo2_tf.id

  issuer   = "https://token.actions.githubusercontent.com"
  subject  = "repo:GabiBM12/secure-networking-private-access:environment:dev"
  audience = ["api://AzureADTokenExchange"]
}
resource "azurerm_federated_identity_credential" "gha_repo2_main2" {
  name                = "fic-repo2-main2"
  resource_group_name = module.rg.name
  parent_id           = azurerm_user_assigned_identity.gha_repo2_tf.id

  issuer   = "https://token.actions.githubusercontent.com"
  subject  = "repo:GabiBM12/secure-networking-private-access:ref:refs/heads/main"
  audience = ["api://AzureADTokenExchange"]
}
output "gha_repo2_client_id" {
  value = azurerm_user_assigned_identity.gha_repo2_tf.client_id
}