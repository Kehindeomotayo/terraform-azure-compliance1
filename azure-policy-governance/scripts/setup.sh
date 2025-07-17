#!/bin/bash
# Azure Policy Governance Setup Script
set -e

echo "Setting up Azure Policy Governance Project..."

# Variables
RESOURCE_GROUP="tfstate-governance-rg"
LOCATION="East US"
CONTAINER_NAME="tfstate"

# Generate unique storage account name (must be globally unique)
TIMESTAMP=$(date +%s)
STORAGE_ACCOUNT="tfstategovernance"

# Check if logged in to Azure
if ! az account show &> /dev/null; then
    echo "Please login to Azure first:"
    echo "az login"
    exit 1
fi

# Display current subscription info
echo "Current Azure subscription:"
az account show --query "{subscriptionId:id, name:name, state:state}" -o table

# Verify subscription access
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
echo "Using subscription: $SUBSCRIPTION_ID"

# Create resource group for Terraform state
echo "Creating resource group for Terraform state..."
az group create --name $RESOURCE_GROUP --location "$LOCATION"

# Check resource providers
echo "Checking Azure resource providers..."
STORAGE_PROVIDER=$(az provider show --namespace Microsoft.Storage --query "registrationState" -o tsv)
echo "Microsoft.Storage provider status: $STORAGE_PROVIDER"

if [ "$STORAGE_PROVIDER" != "Registered" ]; then
    echo "Registering Microsoft.Storage provider..."
    az provider register --namespace Microsoft.Storage
    echo "Waiting for registration to complete..."
    sleep 60
fi

# Try a different approach - check subscription access for storage
echo "Verifying subscription access for storage operations..."
if ! az storage account list --subscription $SUBSCRIPTION_ID &> /dev/null; then
    echo "ERROR: Cannot access storage accounts in subscription $SUBSCRIPTION_ID"
    echo "This might be a permissions issue. Checking your role assignments..."
    az role assignment list --assignee $(az account show --query user.name -o tsv) --output table
    exit 1
fi

# Check if storage account name is available (skip if provider issues)
echo "Checking storage account name availability..."
if NAME_CHECK=$(az storage account check-name --name $STORAGE_ACCOUNT --query "nameAvailable" -o tsv 2>/dev/null); then
    if [ "$NAME_CHECK" != "true" ]; then
        echo "Storage account name $STORAGE_ACCOUNT is not available. Generating new name..."
        STORAGE_ACCOUNT="tfstategovernance$(openssl rand -hex 1)"
        echo "New storage account name: $STORAGE_ACCOUNT"
    fi
else
    echo "Warning: Could not check name availability. Proceeding with generated name..."
fi

# Create storage account for Terraform state
echo "Creating storage account for Terraform state..."
echo "Storage account name: $STORAGE_ACCOUNT"
az storage account create \
    --resource-group $RESOURCE_GROUP \
    --name $STORAGE_ACCOUNT \
    --sku Standard_LRS \
    --encryption-services blob \
    --verbose

# Wait for storage account to be fully provisioned
echo "Waiting for storage account to be ready..."
sleep 10

# Create container for Terraform state
echo "Creating container for Terraform state..."
az storage container create \
    --name $CONTAINER_NAME \
    --account-name $STORAGE_ACCOUNT \
    --auth-mode login

# Get storage account key
echo "Retrieving storage account key..."
STORAGE_KEY=$(az storage account keys list \
    --resource-group $RESOURCE_GROUP \
    --account-name $STORAGE_ACCOUNT \
    --query '[0].value' -o tsv)

# Display backend configuration
echo ""
echo "================================================"
echo "Terraform backend configuration:"
echo "================================================"
echo "resource_group_name  = \"$RESOURCE_GROUP\""
echo "storage_account_name = \"$STORAGE_ACCOUNT\""
echo "container_name       = \"$CONTAINER_NAME\""
echo "key                  = \"governance.tfstate\""
echo ""
echo "Add this to your Terraform backend configuration:"
echo ""
echo "terraform {"
echo "  backend \"azurerm\" {"
echo "    resource_group_name  = \"$RESOURCE_GROUP\""
echo "    storage_account_name = \"$STORAGE_ACCOUNT\""
echo "    container_name       = \"$CONTAINER_NAME\""
echo "    key                  = \"governance.tfstate\""
echo "  }"
echo "}"
echo ""
echo "================================================"
echo "Setup complete!"
echo "================================================"

# Save configuration to file
CONFIG_FILE="terraform-backend-config.txt"
cat > $CONFIG_FILE << EOF
# Terraform Backend Configuration
# Generated on: $(date)

terraform {
  backend "azurerm" {
    resource_group_name  = "$RESOURCE_GROUP"
    storage_account_name = "$STORAGE_ACCOUNT"
    container_name       = "$CONTAINER_NAME"
    key                  = "governance.tfstate"
  }
}

# Environment Variables (optional)
export ARM_STORAGE_ACCOUNT="$STORAGE_ACCOUNT"
export ARM_CONTAINER_NAME="$CONTAINER_NAME"
export ARM_KEY="governance.tfstate"
EOF

echo "Configuration saved to: $CONFIG_FILE"