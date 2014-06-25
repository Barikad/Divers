<# Script Name: Ex5-3b.ps1
   Description: Switches the network adapter to a static configuration.
   Author: Course 969 Scripter
   Version: 1.0
   Date: 6 Mar 12
   Requirements: PowerShell v2.0 or greater
   Notes: 
#>

  # Change the Network Adapter from DHCP to Static
  
  # 18 - Assign IP, subnet mask and DNS
  $IP = "10.1.1.1"
  $Mask = "255.255.255.0"
  $DNS = "10.1.1.100" 
  
  # Return the network adapter with an AdapterType of Ethernet 802.3
  $NIC = Get-WmiObject Win32_NetworkAdapter -Filter 'AdapterType = "Ethernet 802.3"'
  
  # Use Where-Object to return the adapter configuration for the adapter with the
  #  Index property that matches the $NIC DeviceID property
  $Config = Get-WmiObject Win32_NetworkAdapterConfiguration | `
            Where-Object {$_.Index -eq $NIC.DeviceID}
  
  # 19 - Invoke the EnableStatic() method
  $Config.EnableStatic($IP, $Mask)
  
  # 20 - Assign DNS Servers
  $Config.SetDNSServerSearchOrder($DNS)
  
  # Done!
  Write-Host "Network adapter configuration changed to Static"
  
 
  
  


