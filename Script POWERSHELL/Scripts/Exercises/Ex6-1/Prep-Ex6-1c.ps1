<# Script Name: Prep_Ex6-1.ps1
   Description: Creates users in DivisionX Users OU. Randomly selects five user accounts to lock.
   Author: Ron Durbin
   Version: 1.1
   Date: 10 Mar 2013
   Requirements: Course 969 Workstation
   Notes: Updated to be run by students
#>
Import-Module ActiveDirectory

# Create a secure string containing a password
$BadPwd = ConvertTo-SecureString "BadPassword" -AsPlainText -Force

# Prompt for the Division
$Division = "Division" + (Read-Host "Division Number")

# Create new users in DivisionX Users OU
$Counter = 1..50
ForEach ($UserNum in $Counter)
  {New-ADUser -Name ("$Division-User$UserNum") `
              -SAMAccountName ("$Division-User$UserNum") `
              -AccountPassword (ConvertTo-SecureString "Password7" -AsPlainText -Force) `
              -Path ("ou=Users,ou=$Division,dc=Course969,dc=com") `
              -Enabled $True
  }
Write-Host "Division Users created"

# Lock out selected user accounts
$Users = Get-ADUser -SearchBase ("ou=Users,ou=$Division,dc=Course969,dc=com") -filter * | Get-Random -count 5
ForEach ($User in $Users)
  {
    $creds = New-Object System.Management.Automation.PSCredential($User.Name,$BadPwd)
    For ($i=1;$i -le 5;$i++) {New-PSSession -ComputerName DC1 -Credential $creds -ErrorAction SilentlyContinue}
    Write-Host ($User.Name) " is locked"
  }
  
Write-Host "User accounts locked out"
                   