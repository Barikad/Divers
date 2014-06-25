<# Script Name: Ex5-2b.ps1
   Description: Find all non-functional devices on classroom workstations. Save the
     information in a .CSV file.
   Author: Ron Durbin, Owen Rose Consulting LLC
   Version: 1.0
   Date: 6 Mar 12
   Requirements: PowerShell v2.0 or greater, Active Directory domain, Windows 7 or newer
   Notes: 
#>

# Get mandatory parameter consisting of path to CSV file
  Param
    (
      [parameter(Mandatory=$True)]
      [String[]]
      $CSVPath
    )

# Import modules
Write-Host "Importing modules..."
Import-Module ActiveDirectory
Import-Module "C:\Scripts\Answers\Ex4-4\Ex4-4a.psd1"

# Define
  $CSVHeader = "Computer Name,Device Name,PnP Device ID"
   
# Check for a file with the same name; if one exists, delete it
  If (Test-Path $CSVPath) {Remove-Item $CSVPath}

# Create a CSV File and add header
  Write-Host "Creating .CSV file..."
  New-Item -Path $CSVPath -ItemType File
  Add-Content -Path $CSVPath -Value $CSVHeader

# Return all Windows workstations in the Course969.com domain
  Write-Host "Returning all workstations from Active Directory..."
  $Computers = Get-ADComputer -properties OperatingSystem -filter 'OperatingSystem -like "*Ent*prise"'

# Determine which machines are on-line
  Write-Host "Filtering out unreachable workstations..."
  $OnLinePCs = $Computers | Sort-Object -property Name |Where-Object {Get-PingStatus $_.Name} 

# For each online machine, collect information
# Enumerate the OnLinePCs using ForEach-Object
  $OnLinePCs | ForEach-Object {

  # 31 - Start a row of data with the computer name
  Write-Host "Collecting data for " $_.Name "..."
  $Data = $_.Name + ","

  # 32 - Build a WMI Query Language (WQL) query to find non-functional hardware
  $Query =  "SELECT Name, PnPDeviceID "
  $Query += "FROM Win32_PnPEntity "
  $Query += "WHERE ConfigManagerErrorCode <> 0"
  
  # 33 - Execute the query
  $Broken = Get-WmiObject -ComputerName $_.Name -Query $Query 
  
  # 34 - Add OS description to $Data--can use $OS created earlier
  $Data = $Data + $Broken.Name + "," + $Broken.PnPDeviceID

  # 35 - Write information to one row of the CSV file
  Add-Content -Path $CSVPath -Value $Data
}

Write-Host "Done With Inventory"