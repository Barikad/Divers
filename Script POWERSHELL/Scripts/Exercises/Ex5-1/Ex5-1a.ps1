<# Script Name: Ex5-1a
   Description: Copies folders and content while preserving permissions.
   Author: Course 969 Scripter
   Version: 1.0
   Date: 16 Feb 12
   Requirements: Windows 7/Windows Server 2008 or better, PowerShell v2 or better
   Notes: 
#>

# 5 - Get paths to source and sestination folders
Param
    (
        [Parameter(Mandatory = $True)]
        $Old,
        [Parameter(Mandatory = $True)]
        $New
    )
    
# 6 - Copy $Old and all its content to $New

    
# 7 - Get all child folders under $Old and process each in turn
 
        
  # 8 - Assign the source path to a variable
  
        
  # 9 - Assign the path to the same in folder in $New to a variable
  $DestPath = $New + "\" + $_.Parent + "\" + $_.Name
        
  # 10 - Get the ACL of the source folder
  
        
  # 11 - Replace the ACL on the destination with the ACL from the source
  
        

        
        # Commands 8 - 11 above rewritten as a single command
        # This one-line is very compact but also very hard to understand
        # Set-ACL -Path ($New + "\" + $_.Parent + "\" + $_.Name) -ACLObject (Get-ACL -Path $_.FullName)
    
        

