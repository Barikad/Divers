<# Script Name: Ex5-3a.ps1
   Description: Performs several configuration tasks by modifying properties and by invoking
     methods.
   Author: Course 969 Scripter
   Version: 1.0
   Date: 6 Mar 12
   Requirements: PowerShell v2.0 or greater
   Notes: 
#>

# TASK 1

  # Assign a volume name to the C: drive
  # 3 - Get an instance of the C: drive and assign it to the $Drive variable
  $Drive = Get-WmiObject Win32_LogicalDisk -Filter 'DeviceID = "C:"'

  # 4 - Change the Volume Name to "Course 969"
  $Drive.VolumeName = "Course 969"

  # 5 - Commit the change with Put()
  $Drive.Put()
  
# TASK 2

  # Change the Start Mode of the RPCLocator service and start the service
  # 6 - Get a Win32_Service object bound to the RPCLocator Service
  $RPCLoc = Get-WmiObject Win32_Service -Filter "Name = 'RPCLocator'"
  
  # 7 - Change the Start Mode to Automatic using the ChangeStartMode() method
  $RPCLoc.ChangeStartMode("Automatic")
  
  # 8 - Start the RPCLocator Service
  $RPCLoc.StartService()
  
# TASK 3

  # Change the Network Adapter from static configuration to DHCP
  # 9 - Return the network adapter with an AdapterType of Ethernet 802.3
  $NIC = Get-WmiObject Win32_NetworkAdapter -Filter 'AdapterType = "Ethernet 802.3"'
  
  # 10 - Use Where-Object to return the adapter configuration for the adapter with the
  # Index property that matches the $NIC DeviceID property
  $Config = Get-WmiObject Win32_NetworkAdapterConfiguration | `
            Where-Object {$_.Index -eq $NIC.DeviceID}
  
  # 11 - Invoke the EnableDHCP() method
  $Config.EnableDHCP()
  
  # 12 - Clear out the static DNS Server assignments
  $Config.SetDNSServerSearchOrder($Null)
  
  # Done!
  Write-Host "Network adapter configuration changed to DHCP"
  
 
  
  


