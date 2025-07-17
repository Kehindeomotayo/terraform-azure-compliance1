output "policy_assignments" {
  description = "Policy assignments created"
  value = {
    vm_policy_development = {
      name           = module.policies.vm_tags_development_name
      resource_group = module.policies.development_rg_name
      policy_type    = "Custom VM Tags Policy"
    }
    storage_policy_storage_rg = {
      name           = module.policies.storage_tags_storage_rg_name
      resource_group = module.policies.storage_rg_name
      policy_type    = "Custom Storage Tags Policy"
    }
    enterprise_initiative = {
      name           = module.policies.enterprise_initiative_name
      resource_group = module.policies.enterprise_rg_name
      policy_type    = "Enterprise Initiative (Multiple Policies)"
    }
    audit_subscription = {
      name        = module.policies.audit_tags_subscription_name
      scope       = "Subscription"
      policy_type = "Audit Policy"
    }
  }
}

output "resource_groups" {
  description = "Resource groups and their purposes"
  value = {
    development = {
      name    = module.policies.development_rg_name
      purpose = "VM development with VM-specific policy"
    }
    storage = {
      name    = module.policies.storage_rg_name
      purpose = "Storage services with Storage-specific policy"
    }
    enterprise = {
      name    = module.policies.enterprise_rg_name
      purpose = "Enterprise resources with comprehensive initiative"
    }
  }
}

output "ssh_private_key" {
  description = "SSH private key for VM access"
  value       = module.compute.vm_ssh_private_key
  sensitive   = true
}

output "vm_public_ip" {
  description = "Public IP of development VM"
  value       = module.compute.vm_public_ip
}
