<# Script Name: Ex4-2b.ps1
   Description: Returns installed services from the local machine. 
                Services are sorted and displayed by status (Running or Stopped)
   Author: Course 969 Scripter
   Version: 1.0
   Date: 14 Feb 2012
   Requirements: PowerShell v2
   Notes: 
#>

# 12 - Get all installed services
Get-Service | `

# 13 - Sort by Status and Display Name
Sort-Object -Property Status, DisplayName | `

# 14 - Process services from the pipeline
ForEach-Object {

  # 15 - Display stopped services in red, running services in green
  If ($_.status -ieq "Stopped") {Write-Host $_.DisplayName -ForegroundColor "Red"}
  Else {Write-Host $_.DisplayName -ForegroundColor "Green"}

# 16 - Close the loop
}