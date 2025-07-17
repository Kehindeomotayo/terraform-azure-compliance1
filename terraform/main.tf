# Get current client info
data "azurerm_client_config" "current" {}

# Policies module
module "policies" {
  source = "./policies"
}

# Compute module
module "compute" {
  source = "./compute"
}

# Storage module
module "storage" {
  source = "./storage"
}
