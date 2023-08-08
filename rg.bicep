targetScope = 'resourceGroup'

param location string
param rgName string

resource resourcegroup  'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}

output rgId string = rg.id
