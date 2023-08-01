param (
    [string]$ResourceGroupName,
    [string]$FunctionAppName,
    [string]$Location,
    [string]$ClientId,
    [string]$ClientSecret,
    [string]$TenantId
)

# Install Azure PowerShell module if not already installed
if (-not (Get-Module -ListAvailable Az)) {
    Install-Module -Name Az -Force -AllowClobber -Scope CurrentUser
}

# Set the Azure subscription context
Set-AzContext -SubscriptionId "3718112c-afe8-4000-8156-64d160081570" -TenantId "d5b66d53-29b2-4452-ba0f-f8badcf5782d"

# Connect to Azure using service principal credentials
$secureClientSecret = ConvertTo-SecureString $ClientSecret -AsPlainText -Force
$psCredential = New-Object System.Management.Automation.PSCredential ($ClientId, $secureClientSecret)
Connect-AzAccount -ServicePrincipal -Tenant $TenantId -Credential $psCredential

# Create Resource Group
New-AzResourceGroup -Name $ResourceGroupName -Location $Location

# Create Function App
New-AzFunctionApp -ResourceGroupName $ResourceGroupName -Name $FunctionAppName -Location $Location -Runtime 'dotnet'

# You can add more configuration and settings for your Function App if needed.

# Print success message
Write-Host "Deployment completed successfully!"
