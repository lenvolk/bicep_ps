# Variables
. '.\00 Variables.ps1'

# Deployment at scale 
$Vnets=5
# Powershell
for ($vnetno = 1 ; $vnetno -le $Vnets ; $vnetno++) {
    $Vnetname = "PSVNET_$Vnetno"
    az deployment group create --resource-group $RG --template-file .\vnet.bicep --parameters vnetname=$Vnetname
}
# Check Result
az network vnet list -g $RG -o table


# Bicep loop over range
copy .\vnet.bicep vnet_at_scale.bicep
code vnet_at_scale.bicep
az deployment group create --resource-group $RG --template-file .\vnet_at_scale.bicep --parameters vnet_prefix=bicepvnet vnet_count=$vnets
# Check Result
az network vnet list -g $RG -o table

# Bicep loop over array
copy .\vnet.bicep vnet_array.bicep
code vnet_array.bicep
az deployment group create --resource-group $RG --template-file .\vnet_array.bicep
# Check Result
az network vnet list -g $RG -o table