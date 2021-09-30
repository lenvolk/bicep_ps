# Variables
. '.\00 Variables.ps1'

# Authoring and Deploying a Bicep File with Variables and Parameters
copy manual-arm-storage-account.bicep storage-parameters.bicep
# Add Parameters
# Take note of the hints for unused variables and inefficient syntax
# Take note of quick fixes!
code .\storage-parameters.bicep
# Deploy 
az deployment group create --resource-group $RG --template-file .\storage-parameters.bicep
# Deploy with command line parameter 
az deployment group create --resource-group $RG --template-file .\storage-parameters.bicep --parameters storage_name=storageaccount
# LenVolk prefix
az deployment group create --resource-group $RG --template-file .\storage-parameters.bicep --parameters prefix=lenvolk2021
# Deploy with unique command line parameter
az deployment group create --resource-group $RG --template-file .\storage-parameters.bicep --parameters storage_name=storageaccount5314801

# Add Variable
code .\storage-parameters.bicep
# Deploy
az deployment group create --resource-group $RG --template-file .\storage-parameters.bicep --parameters prefix=store
# Deploy again
az deployment group create --resource-group $RG --template-file .\storage-parameters.bicep --parameters prefix=store
# Show result
# Unique string isn't random but hashing!
az resource list --resource-group $RG -o table
az deployment group list --resource-group $RG -o table
# Add deployment name to unique string
code .\storage-parameters.bicep
# Deploy twice
az deployment group create --resource-group $RG --template-file .\storage-parameters.bicep --parameters prefix=storenew 
az deployment group create --resource-group $RG --template-file .\storage-parameters.bicep --parameters prefix=storenew 
# Show result
az resource list --resource-group $RG -o table
az deployment group list --resource-group $RG -o table
# Deploy with new name 
az deployment group create --resource-group $RG --template-file .\storage-parameters.bicep --parameters prefix=storenew --name newnamestorage
# Show result
az resource list --resource-group $RG -o table
az deployment group list --resource-group $RG -o table
# Deploy with invalid SKU
az deployment group create --resource-group $RG --template-file .\storage-parameters.bicep --parameters prefix=store sku=Premium_ZRS
# Deploy with parameter file
code storage-parameters.param.json
az deployment group create --resource-group $RG --template-file .\storage-parameters.bicep --parameters @storage-parameters.param.json
# Show result
az resource list --resource-group $RG -o table
az deployment group list --resource-group $RG -o table

# Variables and Parameters can be objects!
code vnet.bicep
# Deploy
az deployment group create --resource-group $RG --template-file .\vnet.bicep --parameters vnetname=firstvnet

# Objects in combination with parameters
code aks.bicep
# Deploy 
az deployment group create --resource-group $RG --template-file .\aks.bicep --parameters tierType=test
az aks list --resource-group $RG -o table

# Outputs
az deployment group show --resource-group $RG --name vnet > vnet-output.json
code .\vnet-output.json
del .\vnet-output.json

# Add an output
code .\vnet.bicep

# Deploy again
az deployment group create --resource-group $RG --template-file .\vnet.bicep --parameters vnetname=firstvnet

# Check result
az deployment group show --resource-group $RG --name vnet --query 'properties.outputs' 

# We can also use values generated at/resulting from deployment
code aks.bicep

az deployment group create --resource-group $RG --template-file .\aks.bicep `
    --parameters tierType=test --query 'properties.outputs.fqdn.value' -o tsv

# A super useful output: ListKeys()
code .\manual-arm-storage-account.bicep
az deployment group create --resource-group $RG --template-file .\manual-arm-storage-account.bicep `
        --query 'properties.outputs.keys'
    
# Outputs are also a great way to test your variables and functions!
copy aks.bicep output.bicep
code .\output.bicep

az deployment group create --resource-group $RG --template-file .\output.bicep `
    --parameters tierType=test --query 'properties.outputs.deploymentSettings.value' 

az deployment group create --resource-group $RG --template-file .\output.bicep `
    --parameters tierType=prod --query 'properties.outputs.deploymentSettings.value' 

# Variables can also originate from JSON using json(loadTextContent('./file.json'))
code sample.json
code ip-with-JSON.bicep

