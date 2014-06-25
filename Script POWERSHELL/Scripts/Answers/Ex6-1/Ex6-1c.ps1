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

# 23 - Import the Active Directory module

Import-Module ActiveDirectory

$SearchBase = "ou=Users,ou=Division" + (Read-Host "Enter your Division Number") + ",dc=course969,dc=com"

$TempPassword = ConvertTo-SecureString "Password7" -AsPlainText -Force

$LogFilePath = "C:\Scripts\Exercises\Ex6-1\LockedUsers.txt"

$LogFile = New-Item -Path $LogFilePath -ItemType File

# 24 - Get locked user accounts from DivisionX and inject into pipeline
Search-ADAccount -SearchBase $SearchBase -LockedOut -UsersOnly | `

# 25- For each locked user account
ForEach-Object {

  # 26 - Unlock the account
    Unlock-ADAccount -Identity $_.DistinguishedName
  
  # 27 - Reset the password
  
  Set-ADAccountPassword -Identity $_.DistinguishedName -NewPassword $TempPassword -Reset
  
  # 28 - Force password change
  
  Set-ADUser -Identity $_.DistinguishedName -ChangePasswordAtLogon $True

  # 29 - Write each user name to the log file
  
  Add-Content -Path $LogFile -Value $_.Name
  
}

#Done

Write-Host "Done unlocking user accounts"

