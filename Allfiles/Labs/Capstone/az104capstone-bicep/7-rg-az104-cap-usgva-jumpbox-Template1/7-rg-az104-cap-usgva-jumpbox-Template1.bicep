@secure()
param adminpassword string

var networkInterface1_var = 'dsvm-jump-01-nic01'
var networkInterfaceIPConfiguration1 = 'config1'
var resourceGroup1 = 'rg-az104-cap-usgaz-hub'
var subnet1 = 'Subnet-Jumpbox'
var virtualMachine1_var = 'dsvm-jump-02'
var virtualMachineOSDiskWindows1 = 'dsvm-jump-02-osdisk'
var virtualNetwork1 = 'vnet-az104-cap-usgva-hub'

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
      adminPassword: adminpassword
      adminUsername: 'azureadmin'
      computerName: 'dsvm-jump-02'
      secrets: []
      windowsConfiguration: {
      }
    }
    storageProfile: {
      dataDisks: []
      imageReference: {
        offer: 'WindowsServer'
        publisher: 'MicrosoftWindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: virtualMachineOSDiskWindows1
        createOption: 'FromImage'
      }
    }
  }
  zones: []
}