<# Script Name: Ex6-1b.ps1
   Description: Create an Active Directory group and add our new user to it.
   Author: Course 969 Scripter
   Version: 1.0
   Date: 19 Mar 2012
   Requirements: PowerShell v2 or later; Remote Server Administration Tools; Windows Server 2008-R2 Domain
   Notes: 
#>

# 11 - Prompt he user for the division number
$division = Read-Host "Entrez votre numero de divsion Bowdel !!!!"

# 12 - Define Variables
                   $GroupName = "HelpDesk$division"                   $Destination= "cn=Users,dc=course969,dc=com"
                   $Category = "Security"
                   $Scope = "Global"

$PARAM_NEWGROUP= @{'name' = $GroupName;`                   'Samaccountname'= $Groupname;`                   'Path' = $Destination;`
                   'GroupCategory' =$Category ;`
                   'GroupScope' =$Scope}


# 13 - Import AD module
Import-Module ActiveDirectory

# 14 - Create the group
New-ADgroup @PARAM_NEWGROUP


# 15 - Add HelpDeskUser to HelpDesk group

# Done
Write-Host "New group created, user added"