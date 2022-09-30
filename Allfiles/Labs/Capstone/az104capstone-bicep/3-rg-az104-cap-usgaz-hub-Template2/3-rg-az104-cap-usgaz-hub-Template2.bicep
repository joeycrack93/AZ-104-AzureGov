var bastion1_var = 'bast-az104-usgaz'
var networkSecurityGroup1_var = 'NSG-Jumpbox'
var publicIpAddress1_var = 'pip-az104-bast-usgaz'
var subnet1 = 'rg-az104-cap-usgaz-hub'
var subnet2 = 'Subnet-Jumpbox'
var virtualNetwork1_var = 'vnet-az104-cap-usgaz-hub'

resource publicIpAddress1 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: publicIpAddress1_var
  location: resourceGroup().location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    ipTags: []
  }
  zones: []
}

resource networkSecurityGroup1 'Microsoft.Network/networkSecurityGroups@2020-08-01' = {
  name: networkSecurityGroup1_var
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
        '10.52.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnet1
        properties: {
          addressPrefix: '10.52.255.0/24'
          serviceEndpoints: []
          serviceEndpointPolicies: []
          delegations: []
        }
      }
      {
        name: subnet2
        properties: {
          addressPrefix: '10.52.0.0/24'
          networkSecurityGroup: {
            id: networkSecurityGroup1.id
          }
          serviceEndpoints: []
          serviceEndpointPolicies: []
          delegations: []
        }
      }
    ]
  }
}

resource bastion1 'Microsoft.Network/bastionHosts@2021-05-01' = {
  name: bastion1_var
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetwork1_var, subnet1)
          }
          publicIPAddress: {
            id: publicIpAddress1.id
          }
        }
      }
    ]
    scaleUnits: 2
  }
  dependsOn: [
    virtualNetwork1

  ]
}