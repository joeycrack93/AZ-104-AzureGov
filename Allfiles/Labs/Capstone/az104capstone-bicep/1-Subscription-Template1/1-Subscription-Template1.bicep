targetScope = 'subscription'
param location string
param location_usgaz string

var resourceGroup1_var = 'rg-az104-cap-usgaz-hub'
var resourceGroup2_var = 'rg-az104-cap-usgaz-hub'
var resourceGroup3_var = 'rg-az104-cap-usgaz-hub'
var resourceGroup4_var = 'rg-az104-cap-usgva-jumpbox'
var resourceGroup5_var = 'rg-az104-cap-usgaz-jumpbox'
var resourceGroup6_var = 'rg-az104-cap-usgva-keycloak'
var resourceGroup7_var = 'rg-az104-cap-usgva-kion'
var resourceGroup8_var = 'rg-az104-cap-usgva-applications'

resource resourceGroup1 'Microsoft.Resources/resourceGroups@2019-05-01' = {
  name: resourceGroup1_var
  location: location
}

resource resourceGroup2 'Microsoft.Resources/resourceGroups@2019-05-01' = {
  name: resourceGroup2_var
  location: location_usgaz
}

resource resourceGroup3 'Microsoft.Resources/resourceGroups@2019-05-01' = {
  name: resourceGroup3_var
  location: location_usgaz
}

resource resourceGroup4 'Microsoft.Resources/resourceGroups@2019-05-01' = {
  name: resourceGroup4_var
  location: resourceGroup().location
}

resource resourceGroup5 'Microsoft.Resources/resourceGroups@2019-05-01' = {
  name: resourceGroup5_var
  location: resourceGroup().location
}

resource resourceGroup6 'Microsoft.Resources/resourceGroups@2019-05-01' = {
  name: resourceGroup6_var
  location: location
}

resource resourceGroup7 'Microsoft.Resources/resourceGroups@2019-05-01' = {
  name: resourceGroup7_var
  location: location
}

resource resourceGroup8 'Microsoft.Resources/resourceGroups@2019-05-01' = {
  name: resourceGroup8_var
  location: location
}