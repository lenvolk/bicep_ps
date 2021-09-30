@secure()
param pw string

var kvname = 'bcpvault${uniqueString(resourceGroup().id, deployment().name)}'

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: kvname
  location: resourceGroup().location
  properties: {
    enabledForTemplateDeployment: true
    enableRbacAuthorization: true
    tenantId: subscription().tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}

resource keyVaultSecret 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
  name: '${kvname}/adminpassword'
  properties: {
    value: pw
  }
  dependsOn: [
    keyVault
  ]
}

output kvname string = kvname
