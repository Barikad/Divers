

# 3 - Declare the function and parameters
Function Get-IPRange ($Lower=1,$Upper=150)
{
<#
.Synopsis
Returns all IPv4 addresses from $lower to $upper

.Description
This function returns all IPv4 host addresses between $lower and $upper. The network address is specified as a constant in the script.

.Parameter Lower
The lower limit of the IPv4 host addresses

.Parameter Upper
The upper limit of the IPv4 host addresses

.Example
Get-IPRange -Lower 10 -Upper 20
#>

    # 5 - Specify Network Address as a constant
    New-Variable -Name Network -Value "10.1.1." -Option ReadOnly
    
    # 6 - Generate IPv4 adddresses in the specified range
    For ($Node = $Lower; $Node -le $Upper; $Node++) {$Network + $Node}
}
  

# 12 - Declare the Get-PingStatus function and parameter
Function Get-PingStatus ($IP = $Args)
{
<#
.Synopsis
Returns True if a specified IP address or computer is online or False if it is not.

.Description
Get-PingStatus accepts a single IP address or computer name as a parameter and returns a boolean value indicating whether the target is online (True) or unreachable (False).
The function includes a constant that determines how long to wait for a response.
The default wait time is 10 milliseconds.

.Parameter IP
The IPv4 host addresses or computer name to Ping

.Example
Get-PingStatus 10.1.1.1

.Example
Get-PingStatus Workstation1
#>

#13 - Trap the error if an unreachable hostname is provided
Trap {Return "DestinationHostUnreachable"}

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
  


# 20 - Declare the Filter

Filter Get-OnlineMachine
{
<#
.Synopsis
Get-OnlineMachine accepts IPv4 addresses from the command line and returns all addresses that are online.

.Description
This function accepts IPv4 addresses or host names from the pipeline and returns the host addresses only for machines that are online. 

.Example
Get-IPRange -Lower 10 -Upper 20 | Get-OnlineMachine
#>
 
  # 21 - Build the conditional statement
  
    If (Get-PingStatus $_) {$_}
  }
  
Export-ModuleMember -Function Get-IPRange, Get-PingStatus, Get-OnlineMachine 

# DONE
 