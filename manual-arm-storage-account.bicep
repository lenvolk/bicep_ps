resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'myuniquestorage589032'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

output keys object = storageaccount.listkeys()
