# Custom Policy 1: Require specific tags on Virtual Machines
resource "azurerm_policy_definition" "require_vm_tags" {
  name         = "require-vm-mandatory-tags"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Require Mandatory Tags on Virtual Machines"
  #description  = "This policy requires specific tags on all Virtual Machines for compliance and governance"

  metadata = jsonencode({
    category = "Tags"
    version  = "1.0.0"
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Compute/virtualMachines"
        },
        {
          anyOf = [
            {
              field  = "tags['Environment']"
              exists = false
            },
            {
              field  = "tags['Owner']"
              exists = false
            },
            {
              field  = "tags['Department']"
              exists = false
            },
            {
              field  = "tags['Project']"
              exists = false
            },
            {
              field  = "tags['CostCenter']"
              exists = false
            }
          ]
        }
      ]
    }
    then = {
      effect = "deny"
      #details = {
        #message = "Virtual Machines must have the following tags: Environment, Owner, Department, Project, CostCenter"
      #}
    }
  })

  parameters = jsonencode({})
}

# Custom Policy 2: Require specific tags on Storage Accounts
resource "azurerm_policy_definition" "require_storage_tags" {
  name         = "require-storage-mandatory-tags"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Require Mandatory Tags on Storage Accounts"
  #description  = "This policy requires specific tags on all Storage Accounts for compliance and governance"

  metadata = jsonencode({
    category = "Tags"
    version  = "1.0.0"
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Storage/storageAccounts"
        },
        {
          anyOf = [
            {
              field  = "tags['Environment']"
              exists = false
            },
            {
              field  = "tags['Owner']"
              exists = false
            },
            {
              field  = "tags['Department']"
              exists = false
            },
            {
              field  = "tags['Compliance']"
              exists = false
            },
            {
              field  = "tags['DataClassification']"
              exists = false
            }
          ]
        }
      ]
    }
    then = {
      effect = "deny"
      # details = {
      #   message = "Storage Accounts must have the following tags: Environment, Owner, Department, Compliance, DataClassification"
      # }
    }
  })

  parameters = jsonencode({})
}

# Custom Policy 3: Validate Environment tag values
resource "azurerm_policy_definition" "validate_environment_tag" {
  name         = "validate-environment-tag-values"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Validate Environment Tag Values"
  #description  = "This policy validates that Environment tag contains only allowed values"

  metadata = jsonencode({
    category = "Tags"
    version  = "1.0.0"
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          anyOf = [
            {
              field  = "type"
              equals = "Microsoft.Compute/virtualMachines"
            },
            {
              field  = "type"
              equals = "Microsoft.Storage/storageAccounts"
            }
          ]
        },
        {
          field  = "tags['Environment']"
          exists = true
        },
        {
          field = "tags['Environment']"
          notIn = "[parameters('allowedEnvironments')]"
        }
      ]
    }
    then = {
      effect = "deny"
      # details = {
      #   message = "Environment tag must be one of the allowed values: Development, Testing, Staging, Production"
      # }
    }
  })

  parameters = jsonencode({
    allowedEnvironments = {
      type = "Array"
      metadata = {
        displayName = "Allowed Environment Values"
        description = "List of allowed values for Environment tag"
      }
      defaultValue = ["Development", "Testing", "Staging", "Production"]
    }
  })
}

# Custom Policy 4: Audit missing tags (for reporting)
resource "azurerm_policy_definition" "audit_missing_tags" {
  name         = "audit-missing-required-tags"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Audit Resources Missing Required Tags"
  #description  = "This policy audits resources that are missing required tags for compliance reporting"

  metadata = jsonencode({
    category = "Tags"
    version  = "1.0.0"
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          anyOf = [
            {
              field  = "type"
              equals = "Microsoft.Compute/virtualMachines"
            },
            {
              field  = "type"
              equals = "Microsoft.Storage/storageAccounts"
            }
          ]
        },
        {
          anyOf = [
            {
              field  = "tags['Environment']"
              exists = false
            },
            {
              field  = "tags['Owner']"
              exists = false
            },
            {
              field  = "tags['Department']"
              exists = false
            },
            {
              field  = "tags['Project']"
              exists = false
            }
          ]
        }
      ]
    }
    then = {
      effect = "audit"
      # details = {
      #   message = "Resource is missing one or more required tags: Environment, Owner, Department, Project"
      # }
    }
  })

  parameters = jsonencode({})
}