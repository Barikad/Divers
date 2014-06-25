<# Script Name: Ex6-1b.ps1
   Description: Create an Active Directory group and add our new user to it.
   Author: Course 969 Scripter
   Version: 1.0
   Date: 19 Mar 2012
   Requirements: PowerShell v2 or later; Remote Server Administration Tools; Windows Server 2008-R2 Domain
   Notes: 
#>

# 11 - Prompt he user for the division number
$Division = Read-Host "Enter the Division number"

# 12 - Define Variables
$GroupName = "HelpDesk$Division" 
$Destination = "cn=Users,dc=course969,dc=com"
$Category = "Security"
$Scope = "Global"

# 13 - Import AD module

Import-Module ActiveDirectory

# 14 - Create the group

$Group = New-ADGroup -Name $GroupName `
  -SAMAccountName $GroupName `
  -GroupCategory $Category `
  -GroupScope $Scope `
  -Path $Destination 

# 15 - Add HelpDeskUser to HelpDesk group
Add-ADGroupMember -Identity ("cn=$GroupName,$Destination") `
                  -Members ("Helper$Division")

# Done
Write-Host "New group created, user added"