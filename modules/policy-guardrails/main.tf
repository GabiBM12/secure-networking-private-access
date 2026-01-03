resource "azurerm_resource_group_policy_assignment" "this"  {
  for_each = var.assignments

  name                 = each.key
  display_name         = each.value.display_name
  resource_group_id = var.RG_id
  policy_definition_id = each.value.policy_definition_id

  parameters = (
    try(each.value.parameters, null) == null
    ? null
    : jsonencode(each.value.parameters)
  )
}