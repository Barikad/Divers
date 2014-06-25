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
  

  # 4 - Change the Volume Name to "Course 969"
  

  # 5 - Commit the change with Put()
  
  
# TASK 2

  # Change the Start Mode of the RPCLocator service and start the service
  # 6 - Get a Win32_Service object bound to the RPCLocator Service
  
  
  # 7 - Change the Start Mode to Automatic using the ChangeStartMode() method
  
  
  # 8 - Start the RPCLocator Service
  
  
# TASK 3

  # Change the Network Adapter from static configuration to DHCP
  # 9 - Return the network adapter with an AdapterType of Ethernet 802.3
  
  
  # 10 - Use Where-Object to return the adapter configuration for the adapter with the
  # Index property that matches the $NIC DeviceID property
  

  
  # 11 - Invoke the EnableDHCP() method
  
  
  # 12 - Clear out the static DNS Server assignments
  
  
  # Done!
  Write-Host "Network adapter configuration changed to DHCP"
  
 
  
  


