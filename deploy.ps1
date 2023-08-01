param (
    [string]$ResourceGroupName,
    [string]$FunctionAppName,
    [string]$Location,
    [string]$ClientId,
    [string]$ClientSecret,
    [string]$TenantId,
    [string]$SubscriptionId
)

# Install Azure PowerShell module if not already installed
if (-not (Get-Module -ListAvailable Az)) {
    Install-Module -Name Az -Force -AllowClobber -Scope CurrentUser
}

# Set the Azure subscription context
$secureClientSecret = ConvertTo-SecureString $ClientSecret -AsPlainText -Force
$psCredential = New-Object System.Management.Automation.PSCredential ($ClientId, $secureClientSecret)
$azConnection = Connect-AzAccount -ServicePrincipal -Tenant $TenantId -Credential $psCredential -ErrorAction SilentlyContinue

if (!$azConnection) {
    # If the connection attempt failed, try again with the subscription ID
    Connect-AzAccount -ServicePrincipal -Tenant $TenantId -Credential $psCredential -SubscriptionId $SubscriptionId
}

# Create Resource Group
New-AzResourceGroup -Name $ResourceGroupName -Location $Location

# Create Function App
New-AzFunctionApp -ResourceGroupName $ResourceGroupName -Name $FunctionAppName -Location $Location -Runtime 'dotnet'

# You can add more configuration and settings for your Function App if needed.

# Print success message
Write-Host "Deployment completed successfully!"
