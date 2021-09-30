var vnets = [
  'ArrayVNET1'
  'ArrayVNET2'
]

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

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = [for vnet in vnets: {
  name: vnet
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
