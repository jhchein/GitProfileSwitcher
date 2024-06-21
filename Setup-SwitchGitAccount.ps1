<#  
.SYNOPSIS  
Setup script for Switch-GitAccount PowerShell utility.  
  
.DESCRIPTION  
This script checks if the Switch-GitAccount.ps1 is in the system's PATH, adds it if it's not, and creates an empty gitAccounts.json configuration file if it doesn't exist.  
  
.EXAMPLE  
.\Setup-SwitchGitAccount.ps1  
#>  
  
# Function to add a directory to the system PATH  
function Add-Path {
    param (
        [string]$PathToAdd
    )
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if (-not $userPath.Split(';').Contains($PathToAdd)) {
        [Environment]::SetEnvironmentVariable("Path", $userPath + ";$PathToAdd", "User")
    }
    else {
        Write-Host "The directory is already in the PATH."
    }
}
  
# Path to the Switch-GitAccount script  
$scriptName = "Switch-GitAccount.ps1"  
$scriptPath = (Get-Location).Path  

# Check if the Switch-GitAccount script exists in the script directory
$scriptFullPath = Join-Path $scriptPath $scriptName
if (Test-Path $scriptFullPath) {
    Write-Host "The script $scriptName exists in the script directory."
}
else {
    Write-Host "The script $scriptName does not exist in the script directory. Please ensure it's placed in $scriptPath."
    exit 1
}
  
# Check if the script directory is in the PATH  
$path = [Environment]::GetEnvironmentVariable("Path", "Machine")  
if ($path -notmatch [regex]::Escape($scriptPath)) {  
    Write-Host "The script directory is not in the PATH. Adding it now..."  
    Add-Path -PathToAdd $scriptPath  
    Write-Host "Added $scriptPath to the user PATH."  
}
else {  
    Write-Host "The script directory is already in the PATH."  
}  
  
# Path to the JSON configuration file  
$jsonConfigFilePath = Join-Path $scriptPath "gitAccounts.json"  
  
# Create an empty gitAccounts.json file if it doesn't exist  
if (-Not (Test-Path $jsonConfigFilePath)) {  
    Write-Host "Creating empty gitAccounts.json configuration file..."  
    @"  
{  
    "accounts": {  
        // Add your accounts here  
        "example": {  
            "user.name": "your-username",  
            "user.email": "your-email@example.com"  
        }  
    }  
}  
"@ | Set-Content $jsonConfigFilePath  
    Write-Host "Created gitAccounts.json at $jsonConfigFilePath."  
}
else {  
    Write-Host "gitAccounts.json already exists at $jsonConfigFilePath."  
}  
  
# Advisory Notes  
Write-Host "Setup complete."  
Write-Host "Advisory Notes:"  
Write-Host "1. You can manage your Git profiles by editing the gitAccounts.json file."  
Write-Host "2. To add more profiles, follow the structure provided in the example entry."  
Write-Host "3. To remove a profile, delete the corresponding entry in the gitAccounts.json file."  
Write-Host "4. Always ensure the JSON structure is valid after making changes."  
  
# Optional: Add more advisories or configurations as needed.  
