# Variables
code '.\00 Variables.ps1'
. '.\00 Variables.ps1'


# Building and Deploying Bicep
# Creating a Bicep File From an ARM Template
code arm-storage-account.json

# Decompile using built-in command
az bicep decompile --file .\arm-storage-account.json
# Decompile using stand alone CLI
bicep decompile .\arm-storage-account.json

code .\arm-storage-account.bicep

# Creating a Bicep File From Scratch
# From scratch with SSL enforced
code .\manual-arm-storage-account.bicep

# Deploying a Bicep File 
# Azure CLI
az cloud set --name AzureUSGovernment
az login --only-show-errors -o table --query Dummy
az account set -s $Subscription
az account list-locations

# RG Scope
az deployment group create --resource-group $RG --template-file .\manual-arm-storage-account.bicep
# Need the RG first!
az group create --name $RG --location $location
# Try again, but see what would happen first
az deployment group create --resource-group $RG --template-file .\manual-arm-storage-account.bicep --what-if
# Deploy
az deployment group create --resource-group $RG --template-file .\manual-arm-storage-account.bicep
# Bicep is ARM. ARM is desired state. 
az deployment group create --resource-group $RG --template-file .\manual-arm-storage-account.bicep
# Check again what would happen
az deployment group create --resource-group $RG --template-file .\manual-arm-storage-account.bicep --what-if
# Show result
az resource list --resource-group $RG -o table


# Subscription Scope
az deployment sub create --location $location --template-file .\manual-arm-storage-account.bicep
# Try to change scope of deployment
code .\manual-arm-storage-account.bicep
# Create new bicep for a subscription deployment
code .\subscription-scope.bicep
# Deploy RG
az deployment sub create --location $location --template-file .\subscription-scope.bicep

# Management Group Scope
# az deployment mg create --location <location> --template-file <path-to-bicep>

# Tenant Scope
# az deployment tenant create --location <location> --template-file <path-to-bicep>

# PowerShell commandlets:
Connect-AzAccount -Subscription $subscription
# RG Scope
New-AzResourceGroupDeployment -ResourceGroupName $RG -TemplateFile .\manual-arm-storage-account.bicep

# Subscription Scope
# New-AzSubscriptionDeployment -Location <location> -TemplateFile <path-to-bicep>

# Management Group Scope
# New-AzManagementGroupDeployment -Location <location> -TemplateFile <path-to-bicep>

# Tenant Scope
# New-AzTenantDeployment -Location <location> -TemplateFile <path-to-bicep>