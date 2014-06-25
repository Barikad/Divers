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

Import-Module ActiveDirectory

# 5 - Define variables

$Domain = "dc=course969,dc=com"
$UPNSuffix = "@course969.com"

# 6 Prompt for a temporary password as a secure string

$SecureString = Read-Host "Please enter a password" -AsSecureString 

# 7 - Create the user

New-ADUser -Name $UserName `
  -SAMAccountName $UserName `
  -UserPrincipalName ($UserName + $UPNSuffix) `
  -AccountExpirationDate "04/12/2015" `
  -AccountPassword $SecureString `
  -ChangePasswordAtLogon $True `
  -Enabled $True `
  -Path ($Destination + "," + $Domain) 

# Done
Write-Host "New user created"
