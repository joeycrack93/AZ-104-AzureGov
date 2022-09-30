var networkInterface1_var = 'keycloak01-nic'
var networkInterface2_var = 'keycloak02-nic'
var networkInterfaceIPConfiguration1 = 'config1'
var networkInterfaceIPConfiguration2 = 'config1'
var resourceGroup1 = 'rg-az104-cap-usgaz-hub'
var subnet1 = 'vnet-az104-cap-usgva-identity'
var virtualMachine1_var = 'keycloak01'
var virtualMachine2_var = 'keycloak02'
var virtualMachineOSDiskLinux1 = 'keycloak01-osdisk'
var virtualMachineOSDiskLinux2 = 'keycloak02-osdisk'
var virtualNetwork1 = 'vnet-az104-cap-usgva-identity'

resource networkInterface1 'Microsoft.Network/networkInterfaces@2020-08-01' = {
  name: networkInterface1_var
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        properties: {
          subnet: {
            id: resourceId(resourceGroup1, 'Microsoft.Network/virtualNetworks/subnets', virtualNetwork1, subnet1)
          }
        }
        name: networkInterfaceIPConfiguration1
      }
    ]
    enableIPForwarding: false
  }
}

resource virtualMachine1 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: virtualMachine1_var
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface1.id
        }
      ]
    }
    osProfile: {
      adminUsername: 'adminuser'
      computerName: 'vmname'
      secrets: []
    }
    storageProfile: {
      dataDisks: []
      imageReference: {
        offer: '0001-com-ubuntu-server-focal'
        publisher: 'canonical'
        sku: '20_04-lts'
        version: 'latest'
      }
      osDisk: {
        name: virtualMachineOSDiskLinux1
        createOption: 'FromImage'
      }
    }
  }
  zones: []
}

resource networkInterface2 'Microsoft.Network/networkInterfaces@2020-08-01' = {
  name: networkInterface2_var
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        properties: {
          subnet: {
            id: resourceId(resourceGroup1, 'Microsoft.Network/virtualNetworks/subnets', virtualNetwork1, subnet1)
          }
        }
        name: networkInterfaceIPConfiguration2
      }
    ]
    enableIPForwarding: false
  }
}

resource virtualMachine2 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: virtualMachine2_var
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface2.id
        }
      ]
    }
    osProfile: {
      adminUsername: 'adminuser'
      computerName: 'vmname'
      secrets: []
    }
    storageProfile: {
      dataDisks: []
      imageReference: {
        offer: '0001-com-ubuntu-server-focal'
        publisher: 'canonical'
        sku: '20_04-lts'
        version: 'latest'
      }
      osDisk: {
        name: virtualMachineOSDiskLinux2
        createOption: 'FromImage'
      }
    }
  }
  zones: []
}