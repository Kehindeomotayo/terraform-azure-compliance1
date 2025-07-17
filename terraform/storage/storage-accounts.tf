# Random suffix for storage account names
resource "random_string" "storage_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Storage Account in Storage Resource Group - Subject to Storage-specific policy
resource "azurerm_storage_account" "storage_rg_account" {
  name                     = "${lower(replace(var.resource_prefix, "-", ""))}storage${random_string.storage_suffix.result}"
  resource_group_name      = azurerm_resource_group.storage.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Government compliance settings
  min_tls_version           = "TLS1_2"
  enable_https_traffic_only = true

  # These tags are REQUIRED by the Storage policy
  tags = merge(var.common_tags, {
    Environment        = "Production"
    Owner              = "Storage Team"
    Department         = "IT"
    Compliance         = "NIST"
    DataClassification = "Internal"
  })
}

# Storage Account in Enterprise Resource Group - Subject to Enterprise Initiative
resource "azurerm_storage_account" "enterprise_storage" {
  name                     = "${lower(replace(var.resource_prefix, "-", ""))}ent${random_string.storage_suffix.result}"
  resource_group_name      = azurerm_resource_group.enterprise.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  # Government compliance settings
  min_tls_version           = "TLS1_2"
  enable_https_traffic_only = true

  blob_properties {
    versioning_enabled = true
    delete_retention_policy {
      days = 30
    }
  }

  # These tags are REQUIRED by the Enterprise Initiative
  tags = merge(var.common_tags, {
    Environment        = "Production"
    Owner              = "Enterprise Team"
    Department         = "IT"
    Project            = "Enterprise-Storage"
    CostCenter         = "IT-STORAGE-001"
    Compliance         = "NIST"
    DataClassification = "Confidential"
  })
}

# Storage Container for demonstration
resource "azurerm_storage_container" "demo_container" {
  name                  = "demo-data"
  storage_account_name  = azurerm_storage_account.storage_rg_account.name
  container_access_type = "private"
}