# Development Resource Group - Will have VM policy assigned
resource "azurerm_resource_group" "development" {
  name     = "${var.resource_prefix}-development-rg"
  location = var.location

  tags = merge(var.common_tags, {
    Environment = "Development"
    Purpose     = "VM Development Environment"
  })
}

# Storage Resource Group - Will have Storage policy assigned
resource "azurerm_resource_group" "storage" {
  name     = "${var.resource_prefix}-storage-rg"
  location = var.location

  tags = merge(var.common_tags, {
    Purpose = "Storage Services"
  })
}

# Enterprise Resource Group - Will have Initiative (multiple policies) assigned
resource "azurerm_resource_group" "enterprise" {
  name     = "${var.resource_prefix}-enterprise-rg"
  location = var.location

  tags = merge(var.common_tags, {
    Purpose = "Enterprise Resources with Full Governance"
  })
}