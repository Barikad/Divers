<# Script Name: Ex7-1b.ps1
   Description: Set limits on user mailbox
   Author: Course 969 Scripter
   Version: 1.0
   Date: 21 Mar 2012
   Requirements: PowerShell v2, Exchange Server 2010
   Notes: 
#>

# 13 - Load Exchange Management PSSnapIn
Add-PSSnapIn Microsoft.Exchange.Management.PowerShell.E2010

# 14 - Define variables 
$SendReceiveLimit = 10MB    
$SendQuota = 4500MB     
$ReceiveQuota = 5000MB  

# 15 - Modify mailbox properties
Set-Mailbox -Identity "cn=StaffX,ou=Users,ou=DivisionX,dc=course969,dc=com" `
            -MaxSendSize $SendReceiveLimit `
            -MaxReceiveSize $SendReceiveLimit `
            -ProhibitSendQuota $SendQuota `
            -ProhibitSendReceiveQuota $ReceiveQuota
            
# Tell user we're done
Write-Host "Done changing mailbox quotas"

#Done

