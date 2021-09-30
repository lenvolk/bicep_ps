targetScope = 'subscription'

param RG_Name string
param location string

resource bicepRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: RG_Name
  location: location
}

module nsg './nsg.bicep' = {
  scope: bicepRG
  name: 'nsg'
  params: {
    nsg_name: 'nsg'
    allow_rdp: true
  }
}
