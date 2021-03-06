<# Script Name: Ex4-1a.ps1
   Description: Maps a network drive; adds a network printer; displays logon information
   Author: Course 969 Scripter
   Version: 1.0
   Date: 17 Mar 2012
   Requirements: PowerShell v2
   Notes: 
#>

# 3 - Define Constants
New-Variable -name DriveName -Value J: -force
New-Variable -name SharePath -Value \\dc1\install
New-Variable -name PrintPath -Value \\DC1\ADMIN$
New-Variable -name DelayTime -Value 10
New-Variable -name InfoIcon -Value 64
New-Variable -name Caption -Value 'Division 3 Logon'


# 4 - Create a WSH Network Object
$NetWork = New-object -ComObject WScript.Network


# 5 - Create a WSH Shell Object
$shell = New-object -ComObject WScript.shell


# 6 - Create a logon message
$Message = "Vous etes connecté sur " + $Network.ComputerName + " en tant que " + $Network.UserName + "`n"
$Message += "Network drives have been mapped, network printer is installed"

# 7 - Remove existing drive mapping
If (Test-Path $DriveName) {$Network.RemoveNetworkDrive($DriveName)}

# 8 - Map the network drive
$NetWork.MapNetworkDrive($DriveName,$SharePath)

# 9 - Add the network printer
$NetWork.AddWindowsPrinterConnection($PrintPath)

# 10 - Display the logon message
$shell.popup($Message + "`n" + "Affichage de ce message pendant " + $DelayTime + "secondes",$DelayTime,$Caption,$infoicon)

#Done