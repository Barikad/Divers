<# Script Name: Ex6-1a.ps1
   Description: Create a user account. User name and destination OU are mandatory parameters.
     Script prompts for a temporary password. User account is enable and user must change password
     on first logon.
   Author: Course 969 Scripter
   Version: 1.0
   Date: 19 March 2012
   Requirements: PowerShell v2 or later; Remote Server Administration Tools; Windows Server 2008-R2 Domain
   Notes: 
#>

# 3 - Define Parameters
Param(
  [Parameter(Mandatory=$True)]
  [String]$UserName,
  [String]$Destination = "cn=Users"
)

# 4 - Import AD module
import-module ActiveDirectory

# 5 - Define variables
$domain = "dc=course969,dc=com"
$UPNsuffix = "@course969.com"

# 6 Prompt for a temporary password as a secure string
 $SecureString= read-host -AsSecureString "Entre votre mot de passe et vite !!!"

# 7 - Create the user
$PARAM_NEWUSER= @{'Name' = $USERNAME;`
                  'SAMAccountname' = $USERNAME; `                  'UserPrincipalName' = ($USERNAME + $UPNsuffix); `                  'AccountExpirationDate' = "12/12/25";`                  'AccountPassword' = $SecureString;`                  'ChangePasswordAtLogon' = $True;`                  'Enabled' = $True;`                  'Path' = ($Destination + "," + $Domain)}New-Aduser @PARAM_NEWUSER


# Done
Write-Host "New user created"
