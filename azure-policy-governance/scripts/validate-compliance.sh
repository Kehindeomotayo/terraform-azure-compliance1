#!/bin/bash

# Policy Compliance Validation Script
set -e

echo "Validating Policy Compliance..."

# Check policy definitions
echo "Checking custom policy definitions..."
az policy definition list --query "[?policyType=='Custom'].{Name:name, DisplayName:displayName}" -o table

# Check policy assignments
echo "Checking policy assignments..."
az policy assignment list --query "[].{Name:name, DisplayName:displayName, Scope:scope}" -o table

# Check compliance state
echo "Checking compliance state..."
az policy state list --query "[].{ResourceId:resourceId, ComplianceState:complianceState, PolicyDefinitionName:policyDefinitionName}" -o table

# Check for non-compliant resources
echo "Checking for non-compliant resources..."
NON_COMPLIANT=$(az policy state list --filter "complianceState eq 'NonCompliant'" --query "length(@)")

if [ "$NON_COMPLIANT" -gt 0 ]; then
    echo "Warning: Found $NON_COMPLIANT non-compliant resources"
    az policy state list --filter "complianceState eq 'NonCompliant'" --query "[].{ResourceId:resourceId, PolicyDefinitionName:policyDefinitionName}" -o table
else
    echo "All resources are compliant!"
fi

echo "Compliance validation complete!"