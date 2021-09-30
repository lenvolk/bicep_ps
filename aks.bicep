@allowed([
  'test'
  'prod'
])
param tierType string = 'prod'

var deploymentSettings = {
  test: {
    aksname: 'AKS-Test'
    vmSize: 'Standard_D2_v4'
    nodes: 1
  }
  prod: {
    aksname: 'AKS-Prod'
    vmSize: 'Standard_D8_v4'
    nodes: 3
  }
}

resource aks 'Microsoft.ContainerService/managedClusters@2021-03-01' = {
  name: deploymentSettings[tierType].aksname
  location: resourceGroup().location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: 'aks'
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: deploymentSettings[tierType].nodes
        vmSize: deploymentSettings[tierType].vmSize
        mode : 'System'
      }
    ]
  }
}

output fqdn string = aks.properties.fqdn
