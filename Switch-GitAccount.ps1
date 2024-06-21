<#  
.SYNOPSIS  
Switch Git user account configuration between multiple profiles.  
  
.DESCRIPTION  
This script switches the Git user configuration (user.name and user.email) based on the provided account name. It reads the account details from a JSON configuration file. By default, it updates the global Git configuration. You can use the -Local flag to update the local repository configuration instead.  
  
.PARAMETER account  
The name of the account to switch to (e.g., 'work', 'personal').  
  
.PARAMETER Local  
(Optional) Switch the local repository configuration instead of the global configuration.  
  
.EXAMPLE  
Switch-GitAccount.ps1 -account work  
  
.EXAMPLE  
Switch-GitAccount.ps1 -account personal -Local  
#>  
  
param(  
    [string]$account = $(throw "Please provide an account name (e.g., 'work' or 'personal')."),  
    [switch]$Local
)  
  
# Path to the JSON configuration file  
$jsonConfigFilePath = "gitAccounts.json"  
  
if (-Not (Test-Path $jsonConfigFilePath)) {  
    Write-Error "Configuration file not found: $jsonConfigFilePath"  
    exit 1  
}  
  
# Read the JSON file  
$jsonContent = Get-Content $jsonConfigFilePath -Raw | ConvertFrom-Json  
  
if (-Not $jsonContent.accounts.$account) {  
    Write-Error "Account '$account' not found in configuration file."  
    exit 1  
}  
  
# Get the account details  
$userName = $jsonContent.accounts.$account.'user.name'  
$userEmail = $jsonContent.accounts.$account.'user.email'  
  
# Determine the scope (global or local)  
$scopeDescription = if ($Local) { "local" } else { "global" }
  
# Update Git configuration  
if ($Local) {  
    git config --local user.name $userName  
    git config --local user.email $userEmail  
}
else {  
    git config --global user.name $userName  
    git config --global user.email $userEmail  
}  
  
Write-Host "Switched to $account account: $userName <$userEmail> ($scopeDescription)"  
