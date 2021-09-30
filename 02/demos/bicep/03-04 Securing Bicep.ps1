# Variables
. '.\00 Variables.ps1'

# Securing Bicep
code sql.bicep

# Create a KV and secret
code keyvault.bicep

$PW="P@ssw0rdP@ssw0rd"

$KVName= (az deployment group create --resource-group $RG --template-file .\keyvault.bicep `
    --parameters pw=$PW --query 'properties.outputs.kvname.value' -o tsv)

az keyvault secret show --vault-name $KVName --name adminpassword

code sql_kv.bicep

$sqlserver="sqlserver"+(Get-Random -Minimum 100000000 -Maximum 99999999999)

az deployment group create --resource-group $RG --template-file .\sql_kv.bicep `
--parameters sqlServerName=$sqlserver kvName=$KVName

az sql server firewall-rule create -g $RG -s $sqlserver -n 'Azure' --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

$Servername = $sqlserver + '.database.windows.net'
sqlcmd -S $Servername -U sqladmin -P $PW -Q "SELECT @@VERSION"

# Delete RG
az group delete -g $RG --yes