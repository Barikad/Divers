<# Script Name: Ex6-2.ps1
   Description: Reset the built-in Administrator account password
   Author: Course 969 Scripter
   Version: 1.0
   Date: 20 March 2012
   Requirements: PowerShell v2 or newer
   Notes: 
#>

# 2 - Bind to the built-in Administrator account
$Admin = [ADSI]"WinNT://./Administrator,User"

# 3 - Reset the password
$Admin.SetPassword("NewPassword")

# Done
Write-Host "Administrator password reset"