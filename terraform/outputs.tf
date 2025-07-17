# Output important information
output "policy_assignments" {
  description = "Policy assignments created"
  value = {
    vm_policy_development = {
      name           = azurerm_resource_group_policy_assignment.vm_tags_development.name
      resource_group = azurerm_resource_group.development.name
      policy_type    = "Custom VM Tags Policy"
    }
    storage_policy_storage_rg = {
      name           = azurerm_resource_group_policy_assignment.storage_tags_storage_rg.name
      resource_group = azurerm_resource_group.storage.name
      policy_type    = "Custom Storage Tags Policy"
    }
    enterprise_initiative = {
      name           = azurerm_resource_group_policy_assignment.enterprise_initiative.name
      resource_group = azurerm_resource_group.enterprise.name
      policy_type    = "Enterprise Initiative (Multiple Policies)"
    }
    audit_subscription = {
      name        = azurerm_subscription_policy_assignment.audit_tags_subscription.name
      scope       = "Subscription"
      policy_type = "Audit Policy"
    }
  }
}

output "resource_groups" {
  description = "Resource groups and their purposes"
  value = {
    development = {
      name    = azurerm_resource_group.development.name
      purpose = "VM development with VM-specific policy"
    }
    storage = {
      name    = azurerm_resource_group.storage.name
      purpose = "Storage services with Storage-specific policy"
    }
    enterprise = {
      name    = azurerm_resource_group.enterprise.name
      purpose = "Enterprise resources with comprehensive initiative"
    }
  }
}

output "ssh_private_key" {
  description = "SSH private key for VM access"
  value       = tls_private_key.vm_ssh.private_key_pem
  sensitive   = true
}

output "vm_public_ip" {
  description = "Public IP of development VM"
  value       = azurerm_public_ip.vm_dev_ip.ip_address
}