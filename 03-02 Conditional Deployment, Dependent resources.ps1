# Variables
. '.\00 Variables.ps1'

# Conditional Deployment
code nsg.bicep
az deployment group create --resource-group $RG --template-file .\nsg.bicep --parameters nsg_name=nsg_withRDP allow_rdp=true
az deployment group create --resource-group $RG --template-file .\nsg.bicep --parameters nsg_name=nsg_withoutRDP allow_rdp=false
# Check result
az network nsg list -g $rg -o table
az network nsg rule list -g $rg --nsg-name nsg_withRDP -o table
az network nsg rule list -g $rg --nsg-name nsg_withoutRDP -o table

# Deploying Dependent Resources Through Bicep
# Delete RG
az group delete -g $RG --yes
# Extend our existing Subscription Scoped Bicep
code .\subscription-scope.bicep
# Deploy RG
az deployment sub create --location $location --template-file .\subscription-scope.bicep --parameters RG_Name=$RG location=$location
# Check result
az network nsg rule list -g $rg --nsg-name nsg -o table
# Try with another RG
$RG_2="AnotherBicepRG"
az group show -g $RG_2
az deployment sub create --location $location --template-file .\subscription-scope.bicep --parameters RG_Name=$RG_2 location=$location
az network nsg rule list -g $RG_2 --nsg-name nsg -o table
az group delete -g $RG_2 --yes