param (
    [string]$ResourceGroupName,
    [string]$FunctionAppName,
    [string]$Location
)

# Connect to Azure
Connect-AzAccount

# Create Resource Group
New-AzResourceGroup -Name $ResourceGroupName -Location $Location

# Create Function App
New-AzFunctionApp -ResourceGroupName $ResourceGroupName -Name $FunctionAppName -StorageAccount $FunctionAppName -Runtime 'dotnet'

# You can add more configuration and settings for your Function App if needed.

# Print success message
Write-Host "Deployment completed successfully!"
