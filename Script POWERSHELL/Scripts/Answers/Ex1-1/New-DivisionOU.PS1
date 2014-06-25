<# 

SCRIPT:	New-TeamOU.ps1 
AUTHOR: Ron Durbin, Owen Rose Consulting LLC
DATE  : 8/25/09; Revised 09/01/2012
VERSION: 2.0
COMMENT: Creates the OU Structure for DivisionX.
	 Part of Course 969 Ex 1.1

REQUIREMENTS: PowerShell 2 or later; Active Directory domain;
	      Credentials allowing creation of OUs in the domain root container 
#>

# Import the Active Directory Module
# Note that this is not necessary in PowerShell 3
# The command is included to make the script backward-compatible with PowerShell 2.

Import-Module ActiveDirectory

# Prompt the user for their Division Number 
# Append the Division Number to "Division" to get the Division Name

$DivisionName = "Division" + (Read-Host "Enter your Division Number (just the number)")

# Bind to the RootDSE container on the logon server
# Get the distinguished name of the logon domain (the DefaultNamingContext)
# Note that this makes the script portable to other domains

$Domain = (Get-ADRootDSE).DefaultNamingContext

# Create the Division OU
# Add a description

$DivisionOU = New-ADOrganizationalUnit -Name $DivisionName `
               -Path $Domain `
               -ProtectedFromAccidentalDeletion $False `
               -Description "OU created in Exercise 1.1"

# Create Users, Computers, and Resources OUs under the new Division OU
# Create a variable with the path to the Division OU

$OUPath = "ou=$DivisionName,$Domain"

$UsersOU = New-ADOrganizationalUnit -Name "Users" `
           -Path $OUPath `
           -ProtectedFromAccidentalDeletion $False

$ComputersOU = New-ADOrganizationalUnit -Name "Computers" `
               -Path $OUPath `
               -ProtectedFromAccidentalDeletion $False

$ResourcesOU = New-ADOrganizationalUnit -Name "Resources" `
               -Path $OUPath `
               -ProtectedFromAccidentalDeletion $False

# Tell the user we're done

Write-Host "All done creating the $DivisionName OU"

# END