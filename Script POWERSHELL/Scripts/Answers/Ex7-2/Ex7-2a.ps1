<# Script Name: Ex7-2a.ps1
   Description: Create a VM on Windows Hyper-V Server
   Author: Class 969 Scripter
   Version: 1.0
   Date: 21 Mar 2012
   Requirements: PowerShell v2, CodePlex HyperV, Windows Hyper-V Server, hardware resources
   Notes: 
#>

# 6 - Prompt for Division Number
$DivisionNumber = Read-Host "Enter your Division Number"

# 7 - Define Variables
$HostName = "Host100"
$VMName = "Division$DivisionNumber" + "VM"
$VMPath = "D:\VirtualMachines"
$RAM = 128MB
$VSwitch = "Course969"
$VHDName = "Division$DivisionNumber" + "VHD.vhdx"
$VHDPath = "D:\VirtualHardDrives"
$VHDSize = 2GB


# 8 - Create New VM
New-VM -Name $VMName -Path $VMPath -ComputerName $HostName -MemoryStartupBytes $RAM -NewVHDPath "$VHDPath\$VHDName" -NewVHDSizeBytes $VHDSize -SwitchName $VSwitch 
