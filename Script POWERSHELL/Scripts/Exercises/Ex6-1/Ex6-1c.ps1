<# Script Name: Ex6-1c.ps1
   Description: Find all locked user accounts in a Particular DivisionX OU. For each account
     - Unlock the account
     - Reset the password
     - Force password change at next logon
     - Write user name to a log file
   Author: Class 969 Scripter
   Version: 1.0
   Date: 19 Mar 2012
   Requirements: PowerShell v2 or later; Remote Server Administration Tools; Windows Server 2008-R2 Domain
   Notes: 
#>

# 19 - Import the Active Directory module

Import-Module ActiveDirectory

# 20 - Define variables
$SearchBase = "ou=Users,ou=Division" + (Read-Host "Enter your Division Number") + ",dc=course969,dc=com"
$TempPassword = ConvertTo-SecureString "Password7" -AsPlainText -Force
$LogFilePath = "C:\Scripts\Exercises\Ex6-1\LockedUsers.txt"

# 21 - Create Log File
$LogFile = New-Item -Path $LogFilePath -ItemType File

# 22 - Get locked user accounts from DivisionX and inject into pipeline


# 23 - For each locked user account


  # 24 - Unlock the account
    
  
  # 25 - Reset the password
  
 
  
  # 26 - Force password change
  
  

  # 27 - Write each user name to the log file
  
 

#Done

Write-Host "Done unlocking user accounts"

