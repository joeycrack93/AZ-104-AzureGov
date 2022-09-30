var networkSecurityGroup1_var = 'NSG-USGVA-Keycloak'
var networkSecurityGroup2_var = 'NSG-USGVA-Kion'
var storageAccount1_var = 'az104capusgvaidentdiag'
var subnet1 = 'vnet-az104-cap-usgva-identity'
var subnet2 = 'Subnet-Kion'
var virtualNetwork1_var = 'vnet-az104-cap-usgva-identity'

resource storageAccount1 'Microsoft.Storage/storageAccounts@2019-04-01' = {
  name: storageAccount1_var
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  location: resourceGroup().location
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

resource networkSecurityGroup1 'Microsoft.Network/networkSecurityGroups@2020-08-01' = {
  name: networkSecurityGroup1_var
  location: resourceGroup().location
  properties: {
    securityRules: []
  }
}

resource networkSecurityGroup2 'Microsoft.Network/networkSecurityGroups@2020-08-01' = {
  name: networkSecurityGroup2_var
  location: resourceGroup().location
  properties: {
    securityRules: []
  }
}

resource virtualNetwork1 'Microsoft.Network/virtualNetworks@2020-08-01' = {
  name: virtualNetwork1_var
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnet1
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: {
            id: networkSecurityGroup1.id
          }
          serviceEndpoints: []
          serviceEndpointPolicies: []
          delegations: []
        }
      }
      {
        name: subnet2
        properties: {
          addressPrefix: '10.0.2.0/24'
          networkSecurityGroup: {
            id: networkSecurityGroup2.id
          }
          serviceEndpoints: []
          serviceEndpointPolicies: []
          delegations: []
        }
      }
    ]
  }
}