# Initiative 1: VM Governance Initiative
resource "azurerm_policy_set_definition" "vm_governance" {
  name         = "vm-governance-initiative"
  policy_type  = "Custom"
  display_name = "Virtual Machine Governance Initiative"
  description  = "Comprehensive governance policies for Virtual Machines including tagging and compliance"

  metadata = jsonencode({
    category = "Compute"
    version  = "1.0.0"
  })

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_vm_tags.id
    reference_id         = "RequireVMTags"
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.validate_environment_tag.id
    reference_id         = "ValidateEnvironmentTag"
    parameter_values = jsonencode({
      allowedEnvironments = {
        value = ["Development", "Testing", "Staging", "Production"]
      }
    })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.audit_missing_tags.id
    reference_id         = "AuditMissingTags"
  }
}

# Initiative 2: Storage Governance Initiative
resource "azurerm_policy_set_definition" "storage_governance" {
  name         = "storage-governance-initiative"
  policy_type  = "Custom"
  display_name = "Storage Account Governance Initiative"
  description  = "Comprehensive governance policies for Storage Accounts including tagging and compliance"

  metadata = jsonencode({
    category = "Storage"
    version  = "1.0.0"
  })

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_storage_tags.id
    reference_id         = "RequireStorageTags"
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.validate_environment_tag.id
    reference_id         = "ValidateEnvironmentTag"
    parameter_values = jsonencode({
      allowedEnvironments = {
        value = ["Development", "Testing", "Staging", "Production"]
      }
    })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.audit_missing_tags.id
    reference_id         = "AuditMissingTags"
  }
}

# Initiative 3: Enterprise-Wide Governance Initiative
resource "azurerm_policy_set_definition" "enterprise_governance" {
  name         = "enterprise-governance-initiative"
  policy_type  = "Custom"
  display_name = "Enterprise-Wide Governance Initiative"
  description  = "Comprehensive governance policies for all resources across the enterprise"

  metadata = jsonencode({
    category = "General"
    version  = "1.0.0"
  })

  # Include VM policies
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_vm_tags.id
    reference_id         = "RequireVMTags"
  }

  # Include Storage policies
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.require_storage_tags.id
    reference_id         = "RequireStorageTags"
  }

  # Include validation policies
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.validate_environment_tag.id
    reference_id         = "ValidateEnvironmentTag"
    parameter_values = jsonencode({
      allowedEnvironments = {
        value = ["Development", "Testing", "Staging", "Production"]
      }
    })
  }

  # Include audit policies
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.audit_missing_tags.id
    reference_id         = "AuditMissingTags"
  }
}