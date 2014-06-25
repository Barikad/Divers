<# Script Name: Ex4-2a.ps1
   Description: Returns all time-related events from thee local machine. 
   Author: Course 969 Scripter
   Version: 1.0
   Date: 31 Jan 2012
   Requirements: PowerShell v2
   Notes: 
#>

# 3 - Assign the CSV file path to a variable
$CSVPath = "C:\Scripts\Exercises\Ex4-2\TimeSync.csv"
   
# 4 - Get all events from the System event log
Get-WinEvent -LogName "System" | `

# 5 - Keep only time sync events 
Where-Object {$_.ID -eq 35} | `

# 6 - Select properties to be saved
Select-Object -Property MachineName, ID, TimeCreated, Message | `

# 7 - Save events to a CSV file
Export-CSV -Path $CSVPath

# Done



