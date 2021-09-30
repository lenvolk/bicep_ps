param prefix string
param location string = resourceGroup().location

@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param sku string = 'Standard_LRS'

var storage_name = '${toLower(prefix)}${uniqueString(resourceGroup().id, deployment().name)}'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storage_name
  location: location
  kind: 'StorageV2'
  sku: {
    name: sku
  }
  properties: {
    supportsHttpsTrafficOnly: true
  }
}
