<# Script Name: Ex5-2a.ps1
   Description: Inventory Script. Returns workstations in the specified Domain. Verifies 
     machine on-line status. For on-line machines, collect information on CPU, memory, 
     hard drive, screen resolution and OS. Save the results in a CSV file.
   Author: Course 969 Scripter
   Version: 1.0
   Date: 6 Mar 12
   Requirements: PowerShell v2.0 or greater, Active Directory domain, Windows 7 or newer
   Notes: Requires a command line parameter specifying the absolute filesystem path
     to the CSV file containing the results.
#>

# 2 - Get mandatory parameter consisting of path to CSV file
  Param
    (
      [parameter(Mandatory=$True)]
      [String]
      $CSVPath
    )

# 3 - Import modules
Write-Host "Importing modules..."
Import-Module ActiveDirectory
Import-Module C:\Scripts\Answers\Ex4-4\Ex4-4a.psd1

# 4 - Define the column headers for the csv file
  $ComputerHeader = "Computer Name,"
  $CPUHeader = "CPU Cores,CPU Description,CPU Speed (MHz),"
  $MemoryHeader = "Visible Memory (MB),"
  $DriveHeader = "Drive Capacity (MB),Drive Free Space (MB),"
  $DisplayHeader = "Screen Width,Screen Height,"
  $OSHeader = "Operating System"
  $CSVHeader = $ComputerHeader + $CPUHeader + $MemoryHeader + $DriveHeader + $DisplayHeader + $OSHeader

# 5 - Check for a file with the same name; if one exists, delete it
  
 
# 6 - Tell the user we're creating the CSV file
  
  
# 7 - Create the CSV file
  
  
# 8 - Add the column headers to the file
  

# 9 - Return all Windows workstations in the Course969.com domain
  Write-Host "Returning all workstations from Active Directory..."
  $Computers = Get-ADComputer -properties OperatingSystem -filter 'OperatingSystem -like "*Ent*prise"'

# 10 - Determine which machines are on-line
  Write-Host "Filtering out unreachable workstations..."
  $OnLinePCs = $Computers | Sort-Object -property Name |Where-Object {Get-PingStatus $_.Name} 

# 11 - Enumerate the OnLinePCs using ForEach-Object


  # 12 - Start a row of data with the computer name
  Write-Host "Collecting data for $_.Name ..."
  
  # 13 - Save the name of the current workstation
  

  # 14 - Use WMI to return an collection representing the CPU(s)
   
  
  # 15 - Get the number of CPU cores; add it to $Data
  
  
  # 16 - Get the Description property of the first CPU instance and add it to $Data
  
  
  # 17 - Add the CurrentClockSpeed property of the first CPU instance to $Data
  
  
  # 18 - Use WMI to create an instance of the WMI Operating System class 
  
  
  # 19 - Convert memory size from KB to MB
  $Mem = [System.Math]::Round($OS.TotalVisibleMemorySize / 1KB)
  
  # 20 - Assign the total visible memory property to $Data
  

  # 21 - Create a WMI object representing the C: drive
  

  # 22 - Convert hard drive size and free space from B to MB
  $HDSize = [System.Math]::Round($HD.Size / (1MB))
  $HDFree = [System.Math]::Round($HD.FreeSpace / (1MB))
  
  # 23 - Add the size and free space properties to $Data
  

  # 24 - Create an instance of the WMI Display object
  
 
  # 25 - Add the display horizontal and vertical resolution to $Data
  

  # 26 - Add OS description to $Data--can use $OS created earlier
  

  # 27 - Write information to one row of the CSV file
  


Write-Host "Done With Inventory"


