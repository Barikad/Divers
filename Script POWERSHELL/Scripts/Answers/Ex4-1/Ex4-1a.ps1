<# Script Name: Ex4-1a.ps1
   Description: Maps a network drive; adds a network printer; displays logon information
   Author: Course 969 Scripter
   Version: 1.0
   Date: 17 Mar 2012
   Requirements: PowerShell v2
   Notes: 
#>

# 3 - Define Constants
New-Variable -Name DriveName -Value 'J:' -Option ReadOnly
New-Variable -Name SharePath -Value '\\DC1\Install' -Option ReadOnly
New-Variable -Name PrintPath -Value '\\DC1\Admins' -Option ReadOnly
New-Variable -Name DelayTime -Value 10 -Option ReadOnly
New-Variable -Name InfoIcon -Value 64 -Option ReadOnly
New-Variable -Name Caption -Value 'DivisionX Logon' -Option ReadOnly

# 4 - Create a WSH Network Object
$Network = New-Object -ComObject "WScript.Network"

# 5 - Create a WSH Shell Object
$Shell = New-Object -ComObject "WScript.Shell"

# 6 - Create a logon message
$Message = "You have logged on to " + $Network.ComputerName + " as " + $Network.UserName + "`n"
$Message += "Network drives have been mapped, network printer is installed"

# 7 - Remove existing drive mapping
If (Test-Path $DriveName) {$Network.RemoveNetworkDrive($DriveName)}

# 8 - Map the network drive
$Network.MapNetworkDrive($DriveName,$SharePath)

# 9 - Add the network printer
$Network.AddWindowsPrinterConnection($PrintPath)

# 10 - Display the logon message
$Shell.PopUp($Message,$DelayTime,$Caption,$InfoIcon) 

#Done