module "compute" {
  source         = "./compute"
  development_rg = azurerm_resource_group.development.name
  location       = azurerm_resource_group.development.location
}

module "storage" {
  source        = "./storage"
  storage_rg    = azurerm_resource_group.storage.name
  enterprise_rg = azurerm_resource_group.enterprise.name
  location      = var.location
}

module "policies" {
  source          = "./policies"
  development_rg  = azurerm_resource_group.development
  storage_rg      = azurerm_resource_group.storage
  enterprise_rg   = azurerm_resource_group.enterprise
  subscription_id = data.azurerm_client_config.current.subscription_id
}


# # main.tf - Root module that calls submodules

# # Call the policies module
# module "policies" {
#   source = "./policies"

#   # Pass any required variables to the policies module
#   subscription_id     = var.subscription_id
#   resource_group_name = var.resource_group_name
# }

# # Call the compute module
# module "compute" {
#   source = "./compute"

#   # Pass any required variables to the compute module
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   vm_size             = var.vm_size
# }

# # Call the storage module
# module "storage" {
#   source = "./storage"

#   # Pass any required variables to the storage module
#   resource_group_name  = var.resource_group_name
#   location             = var.location
#   storage_account_name = var.storage_account_name
# }

# # Outputs referencing module outputs instead of direct resources
# output "policy_assignments" {
#   value = {
#     vm_tags_development = {
#       name = module.policies.vm_tags_development_assignment_name
#     }
#     storage_tags_storage_rg = {
#       name = module.policies.storage_tags_assignment_name
#     }
#     enterprise_initiative = {
#       name = module.policies.enterprise_initiative_assignment_name
#     }
#     audit_tags_subscription = {
#       name = module.policies.audit_tags_subscription_assignment_name
#     }
#   }
# }

# output "ssh_private_key" {
#   value     = module.compute.ssh_private_key
#   sensitive = true
# }

# output "vm_public_ip" {
#   value = module.compute.vm_public_ip
# }