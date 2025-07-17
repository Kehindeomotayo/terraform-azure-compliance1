# policies/outputs.tf

output "vm_tags_development_assignment_name" {
  value = azurerm_resource_group_policy_assignment.vm_tags_development.name
}

output "storage_tags_assignment_name" {
  value = azurerm_resource_group_policy_assignment.storage_tags_storage_rg.name
}

output "enterprise_initiative_assignment_name" {
  value = azurerm_resource_group_policy_assignment.enterprise_initiative.name
}

output "audit_tags_subscription_assignment_name" {
  value = azurerm_subscription_policy_assignment.audit_tags_subscription.name
}