var appService1_var = 'webapp-az104-cap-wordpress'
var kubernetesServiceAgentPoolPrimarySystem1 = 'aks-az104-cap-pool'
var kubernetesServiceContainer1_var = 'aks-az104-cap-helloworld'
var webServerfarm1_var = 'asp-az104-cap-wordpress'

resource kubernetesServiceContainer1 'Microsoft.ContainerService/managedClusters@2021-08-01' = {
  name: kubernetesServiceContainer1_var
  location: resourceGroup().location
  properties: {
    agentPoolProfiles: [
      {
        name: kubernetesServiceAgentPoolPrimarySystem1
        type: 'AvailabilitySet'
        count: 1
        mode: 'System'
        nodeTaints: []
        osType: 'Linux'
        vmSize: 'Standard_B2ms'
      }
    ]
    enableRBAC: true
    kubernetesVersion: '1.21.2'
  }
}

resource webServerfarm1 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: webServerfarm1_var
  location: resourceGroup().location
  properties: {
  }
  sku: {
    name: 'F1'
  }
}

resource appService1 'Microsoft.Web/sites@2020-12-01' = {
  name: appService1_var
  kind: 'app'
  location: resourceGroup().location
  properties: {
    httpsOnly: true
    serverFarmId: webServerfarm1.id
    siteConfig: {
      appSettings: []
      connectionStrings: []
      defaultDocuments: []
      detailedErrorLoggingEnabled: true
      handlerMappings: []
      httpLoggingEnabled: true
      ipSecurityRestrictions: []
      minTlsVersion: '1.2'
      remoteDebuggingEnabled: false
      scmIpSecurityRestrictions: []
      webSocketsEnabled: false
    }
  }
}