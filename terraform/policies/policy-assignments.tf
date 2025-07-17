# Assignment 1: VM-specific policy to Development Resource Group
resource "azurerm_resource_group_policy_assignment" "vm_tags_development" {
  name                 = "vm-tags-development-assignment"
  resource_group_id    = azurerm_resource_group.development.id
  policy_definition_id = azurerm_policy_definition.require_vm_tags.id
  display_name         = "VM Tags Policy - Development RG"
  description          = "Enforces mandatory tags on VMs in Development Resource Group"

  metadata = jsonencode({
    assignedBy = "Terraform"
    category   = "Tags"
  })
}

# Assignment 2: Storage-specific policy to Storage Resource Group
resource "azurerm_resource_group_policy_assignment" "storage_tags_storage_rg" {
  name                 = "storage-tags-storage-assignment"
  resource_group_id    = azurerm_resource_group.storage.id
  policy_definition_id = azurerm_policy_definition.require_storage_tags.id
  display_name         = "Storage Tags Policy - Storage RG"
  description          = "Enforces mandatory tags on Storage Accounts in Storage Resource Group"

  metadata = jsonencode({
    assignedBy = "Terraform"
    category   = "Tags"
  })
}

# Assignment 3: Enterprise Initiative to Enterprise Resource Group
resource "azurerm_resource_group_policy_assignment" "enterprise_initiative" {
  name                 = "enterprise-governance-assignment"
  resource_group_id    = azurerm_resource_group.enterprise.id
  policy_definition_id = azurerm_policy_set_definition.enterprise_governance.id
  display_name         = "Enterprise Governance Initiative - Enterprise RG"
  description          = "Comprehensive governance policies for Enterprise Resource Group"

  metadata = jsonencode({
    assignedBy = "Terraform"
    category   = "Governance"
  })
}

# Assignment 4: Audit policy at subscription level (for reporting)
data "azurerm_subscription" "current" {}

resource "azurerm_subscription_policy_assignment" "audit_tags_subscription" {
  name                 = "audit-tags-subscription"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.audit_missing_tags.id
  display_name         = "Audit Missing Tags - Subscription Level"
  description          = "Audits all resources across subscription for missing required tags"

  metadata = jsonencode({
    assignedBy = "Terraform"
    category   = "Audit"
  })
}