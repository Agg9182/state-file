# Set RESOURCE_GROUP_NAME in the environment (e.g. GitHub Actions workflow input) or default for local runs.
$RESOURCE_GROUP_NAME = if ($env:RESOURCE_GROUP_NAME) { $env:RESOURCE_GROUP_NAME } else { 'rg-tfstate' }
$STORAGE_ACCOUNT_NAME="tfstate$(Get-Random)"
$CONTAINER_NAME='tfstate'

# Create resource group
New-AzResourceGroup -Name $RESOURCE_GROUP_NAME -Location eastus

# Create storage account
$storageAccount = New-AzStorageAccount -ResourceGroupName $RESOURCE_GROUP_NAME -Name $STORAGE_ACCOUNT_NAME -SkuName Standard_LRS -Location eastus -AllowBlobPublicAccess $false

# Create blob container
New-AzStorageContainer -Name $CONTAINER_NAME -Context $storageAccount.context

# Let the same service principal (ARM_CLIENT_ID) use the data plane for Terraform remote state (Azure AD auth to blob)
if ($env:ARM_CLIENT_ID) {
  try {
    $sp = Get-AzADServicePrincipal -ApplicationId $env:ARM_CLIENT_ID -ErrorAction Stop
    $null = New-AzRoleAssignment -ObjectId $sp.Id -RoleDefinitionName 'Storage Blob Data Contributor' -Scope $storageAccount.Id -ErrorAction SilentlyContinue
  } catch {
    Write-Warning "Could not assign Storage Blob Data Contributor to the SP: $_"
  }
}

$ACCOUNT_KEY=(Get-AzStorageAccountKey -ResourceGroupName $RESOURCE_GROUP_NAME -Name $STORAGE_ACCOUNT_NAME)[0].value
$env:ARM_ACCESS_KEY=$ACCOUNT_KEY

$env:TFSTATE_RESOURCE_GROUP=$RESOURCE_GROUP_NAME
$env:TFSTATE_STORAGE_ACCOUNT=$STORAGE_ACCOUNT_NAME
$env:TFSTATE_CONTAINER=$CONTAINER_NAME

# Same directory as this script (repo root): backend config for Terraform partial azurerm backend
$repoRoot = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$backendHcl = Join-Path $repoRoot 'tfstate.backend.hcl'
@(
  "resource_group_name  = `"$RESOURCE_GROUP_NAME`""
  "storage_account_name = `"$STORAGE_ACCOUNT_NAME`""
  "container_name       = `"$CONTAINER_NAME`""
  "key                  = `"terraform.tfstate`""
  "use_azuread_auth     = true"
) | Set-Content -Path $backendHcl -Encoding utf8
Write-Host "Wrote $backendHcl — run: terraform init -backend-config=tfstate.backend.hcl"
