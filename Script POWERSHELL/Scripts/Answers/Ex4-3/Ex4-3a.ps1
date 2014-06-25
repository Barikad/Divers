<# Script Name: Ex4-3a.ps1
   Description: Contains functions and filters to implement Ping functionality
   Author: Course 969 Scripter
   Version: 1.0
   Date: 15 Feb 12
   Requirements: PowerShell v2
   Notes: 
#>

# Implemet a function to generate all IPs between upper and lower limits

# Declare a function named Get-IPRange with two parameters
# Lower is the starting Host address
# Upper is the ending Host address

# 3 - Declare the function and parameters
Function Get-IPRange ($Lower=1,$Upper=150)
  {
   
    # 5 - Specify Network Address as a constant
    New-Variable -Name Network -Value "10.1.1." -Option ReadOnly
    
    # 6 - Generate IPv4 adddresses in the specified range
    For ($Node = $Lower; $Node -le $Upper; $Node++) {$Network + $Node}
  }
  

# Declare a function named Get-PingStatus to determine if a machine is reachable
# $IP is the IP address of the machine to check
# $Wait is a constant that specifies how long (in milliseconds) to wait for a reply
  
# 12 - Declare the Get-PingStatus function and parameter
Function Get-PingStatus ($IP = $Args)
{
# 13 - Trap any errors if a non-existent host name is passed
  #Trap{Return "DestinationHostUnreachable"}

    # 14 - Specify wait time as a constant
    New-Variable -Name Wait -Value 10 -Option ReadOnly

    # 15 - Create an instance of the Ping object
    $Ping = New-Object System.Net.NetworkInformation.Ping
      
    # 16 - Get the status of the specified machine
    $Response = $Ping.Send($IP, $Wait)
    
    # 17 - Return TRUE if machine is online, FALSE if not
    If ($Response.Status -ieq "Success")
      {$True}
    Else
      {$FALSE}
  }
  
  
# Declare a filter that takes IP addresses from the pipeline and returns
#  the IP addresses of the machines that are online

# 20 - Declare the Filter

Filter Get-OnlineMachine
  {
  # Get-OnLineMachine is a filter that accepts IPv4 addresses or computer names
  # from the pipeline and returns only the IP addresses of machines that are online.
  # 21 - Build the conditional statement
  
    If (Get-PingStatus $_) {$_}
  }
  
# DONE
   