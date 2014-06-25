<#
Script Name: Profile.ps1
Version 1.0
Date: 17 Jul 2013
Author: Course 969 Scripter
Description: AllUsersAllHosts Profile
#>

# Declare Variables
$UserName = Get-Content Env:\UserName

# Define Aliases
New-Alias gho Get-Host

# Create an instance of the Host.UI.RawUI object
$UI = (Get-Host).UI.RawUI

# Modify the Title Bar
$UI.WindowTitle = "Course 969 $UserName"

# Apply new color settings to the PowerShell Console only
If ($Host.Name -ieq 'ConsoleHost') 
{$UI.BackgroundColor = "White"
 $UI.ForegroundColor = "Blue"}

# Change the working directory to C:\
Set-Location C:\

# Clear the screen to apply the visual changes
Clear-Host