output "assignment_ids" {
    description = "Policy assignment IDs keyed by assignment name"
  value = { for k, v in azurerm_resource_group_policy_assignment.this : k => v.id }
}
 
  