<# Script Name: Ex6-2b.ps1
   Description: Add the ActiveDirectory HelpDesk group to the local Administrators group on every workstation
   Author: Course 969 Scripter
   Version: 1.0
   Date: 20 March 2012
   Requirements: PowerShell v2 or newer, Remote Server Administration Tools, Windows Server 2008 R2 domain
   Notes: 
#>

# Import modules
Write-Host "Importing modules..."
Import-Module ActiveDirectory
Import-Module C:\Scripts\Answers\Ex4-4\Ex4-4a.psd1

# 9 - Get Division Number
$DivisionNumber = Read-Host "Enter your Division Number"

# 10 - Return all Windows workstations in the Course969.com domain
  Write-Host "Returning all workstations from Active Directory..."
  $Computers = Get-ADComputer  -filter 'OperatingSystem -like "*Enterprise"'

# 11 - Determine which machines are on-line
  Write-Host "Filtering out unreachable workstations..."
  $OnLinePCs = $Computers | Sort-Object -property Name |Where-Object {Get-PingStatus $_.Name} 

# 12 - Enumerate the OnLinePCs using ForEach-Object
$OnLinePCs | ForEach-Object {

  # 13 - Build the path to the current machine's Administrators group
  $AdminsPath = "WinNT://" + $_.Name + "/Administrators, Group"
  
  # 14 - Build the path to the AD HelpDeskX group
  $HelpDeskPath = "WinNT://Course969/HelpDesk$DivisionNumber,Group"
  
  # 15 - Bind to the local Administrators group
  $Admins = [ADSI]$AdminsPath

  # 16 - Add the HelpDeskX group to the Administrators group
  $Admins.Add($HelpDeskPath)
  
  # Update the user on our progress
  Write-Host "HelpDesk$DivisionNumber added to " $_.Name " Administrators group"
  
}

# DONE