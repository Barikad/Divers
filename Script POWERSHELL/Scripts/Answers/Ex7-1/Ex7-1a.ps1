<# Script Name: Ex7-1.ps1
   Description: Create a mailbox and user
   Author: Course 969 Scripter
   Version: 1.0
   Date: 20 March 2012
   Requirements: PowerShell V2, Active Directory, Exchange Server 2010, Remote Server Administration Tools
   Notes: 
#>
# 3 - Load Exchange Management PSSnapIn
Add-PSSnapIn Microsoft.Exchange.Management.PowerShell.E2010

# 4 - Prompt for the team number
$DivisionNumber = Read-Host "Enter the DivisionNumber"

# 5 - Define variables
$Name = "Staff" + $DivisionNumber
$TargetOU = "Course969.com/Division" +$DivisionNumber + "/Users"
$UPN = $Name + "@course969.com"

# 6 - Convert password to secure string
$Password = ConvertTo-SecureString "Password7" -AsPlainText -Force

# 7 - Create the new mailbox and user
New-Mailbox -Name $Name `
            -SAMAccountName $Name `
            -UserPrincipalName $UPN `
            -Password $Password `
            -OrganizationalUnit $TargetOU `
         

#Done
Write-Host "Mailbox Created"            