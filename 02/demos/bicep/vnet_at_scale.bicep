param vnet_prefix string
param vnet_count int

param vNetSettings object = {
  addressPrefix: '10.0.0.0/22'
  subnets: [
    {
      name: 'firstSubnet'
      addressPrefix: '10.0.0.0/24'
    }
    {
      name: 'secondSubnet'
      addressPrefix: '10.0.1.0/24'
    }
  ]
}

@batchSize(2)
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = [for i in range(0, vnet_count): {
  name: '${vnet_prefix}${i}'
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vNetSettings.addressPrefix
      ]
    }
    subnets: [
      {
        name: vNetSettings.subnets[0].name
        properties: {
          addressPrefix: vNetSettings.subnets[0].addressPrefix
        }
      }
      {
        name: vNetSettings.subnets[1].name
        properties: {
          addressPrefix: vNetSettings.subnets[1].addressPrefix
        }
      }
    ]
  }
}]
