@secure()
param vnetname string

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

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  //name: 'vnet${vnetname}'
  name: vnetname
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
}

output vnetname string = vnetname
output vnettype string = virtualNetwork.type
output subnet1 string = vNetSettings.subnets[0].name
output subnet2 string = vNetSettings.subnets[1].name
output subnets object = virtualNetwork.properties.subnets[0].name

