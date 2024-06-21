# Switch-GitAccount  

This project provides a PowerShell script to easily switch between multiple Git user profiles, making it simple to manage different Git configurations for work, personal projects, or any other accounts.  

## Overview  

This PowerShell script reads from a JSON configuration file (`gitAccounts.json`) to switch the Git user configuration (`user.name` and `user.email`) based on the provided account name. By default, it updates the global Git configuration. You can use the `-Local` flag to update the local repository configuration instead.  

## Usage  

All that is needed to know for the impatient.

### Global Configuration  

```powershell  
.\Switch-GitAccount.ps1 -account work  
```  

### Local Configuration  

```powershell  
.\Switch-GitAccount.ps1 -account personal -Local  
```  

## Prerequisites  

Before you use the script, ensure you have the following:  

- PowerShell installed on your machine.  
- A JSON configuration file (`gitAccounts.json`) with your account details.  

## Configuration File  

Create a `gitAccounts.json` file in the same directory as the script with the following structure:  

```json  
{  
    "accounts": {  
        "work": {  
            "user.name": "your-work-username",  
            "user.email": "your-work-email@example.com"  
        },  
        "personal": {  
            "user.name": "your-personal-username",  
            "user.email": "your-personal-email@example.com"  
        }  
    }  
}  
```  

## Installation and Setup  

### Download the Script  

Clone the repository or download the `Switch-GitAccount.ps1` script directly.  

```bash  
git clone https://github.com/jhchein/Switch-GitAccount.git  
cd Switch-GitAccount  
```  

### Set Up the Configuration File  

Ensure your `gitAccounts.json` file is properly set up in the same directory.  

## Running the Script  

Once the script and configuration file are ready, you can run the script to switch between different Git profiles.  

### Example Commands  

#### Switch to the Work Account (Global)  

```powershell  
.\Switch-GitAccount.ps1 -account work  
```  

#### Switch to the Personal Account (Local)  

```powershell  
.\Switch-GitAccount.ps1 -account personal -Local  
```

## License  
   
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). 
