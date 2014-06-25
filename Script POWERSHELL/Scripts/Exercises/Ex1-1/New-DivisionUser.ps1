<#
SCRIPT: New-DivisionUser.ps1
 
AUTHOR: Ron Durbin, Owen Rose Consulting LLC
DATE  : 25 Aug 09; Revised 1 Sep 12
 
COMMENT: Creates users from information in a CSV file
REQUIREMENT: PowerShell v2 or newer; Exchange Management Tools
#>
$ErrorActionPreference = "SilentlyContinue"
# Load the Exchange Management PowerShell PSSnapIn
if (!(Get-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010)) {
    Add-PSSnapIn Microsoft.Exchange.Management.PowerShell.E2010
}
$ErrorActionPreference = "Continue"
# Load PowerShell ActiveDirectory module
if(!(get-module ActiveDirectory)) {
    Import-Module ActiveDirectory
}

# Set Verbose Preference to SilentlyContinue
$VerbosePreference = 'SilentlyContinue'

# Set path to NewHires.csv file
$NewHiresPath = "\\DC1\Install\NewHires.csv"

# Specify the name of the Mail Server and Mailbox Database
$MailHost = Get-MailboxServer
Write-Verbose "Mail Server: $MailHost"
$Database  = Get-MailboxDatabase
Write-Verbose "Mailbox Database: $Database"

# Bind to RootDSE and return the DN and FQDN of the domain
$RootDSE = Get-ADRootDSE
$DomainDN = $RootDSE.DefaultNamingContext
$Domain = $ENV:UserDomain
$FQDN = $RootDSE.DNSHostName
Write-Verbose "Domain Distinguished Name: $DomainDN"

# Prompt the user for credentials for running the script
$Credentials = Get-Credential -UserName "$ENV:UserName@$Domain.com" `
               -Message "Please enter the password for the currently logged-on user"

# Prompt user for Division Number and create the Division Name
$DivisionNumber = Read-Host "Enter your Division Number (just the number)"
$DivisionName = "Division$DivisionNumber"
Write-Verbose "Division Name: $DivisionName"

# DivisionX Users OU Path
$UsersOUPath = "ou=Users,ou=$DivisionName,$DomainDN"
Write-Verbose "User OU Path: $UsersOUPath"

# Read the CSV file and store the new user information in $NewHires
$NewHires = Import-Csv -Path $NewHiresPath
Write-Verbose "NewHires.CSV file successfully opened"

# Save the new user temporary password as a secure string
$SSPassword = ConvertTo-SecureString "Password7" -asplaintext -force
Write-Verbose "Password converted to secure string"

# Create the new users
Write-Host "Processing new hires..."
$NewHires | ForEach-Object -process `
{
	# Build the user common name from the last name, first letter of the first name
	#  and the Division Number
	$UserCN = ($_."Last Name") + ($_."First Name".Substring(0,1)) + ($DivisionNumber)
	Write-Verbose "User Common Name: $UserCN"

    # Build the User Principal Name
	$UPN = "$UserCN@$Domain.com"
	Write-Verbose "User Principal Name: $UPN"

    # Build the User Display Name
	$DisplayName = ($_."First Name") + "." + ($_."Last Name") + ($DivisionNumber)
	Write-Verbose "User Display Name: $DisplayName"

    # Build the user e-mail address
	$EMailAddress = "$UserCN@$Domain.com"
	Write-Verbose "User E-Mail Address: $EMailAddress"

    # Build the User Distinguished Name
    $UserDN = "cn=$UserCN,$UsersOUPath"
    Write-Verbose "User Distinguished Name: $UserDN"

    # Build a hashtable containing the name-value pairs for the new user and mailbox
    $MailUser = @{
      Name = $UserCN
      UserPrincipalName = $UPN
      Password = $SSPassword
      OrganizationalUnit = $UsersOUPath
      DisplayName = $DisplayName
      FirstName = $_."FirstName"
      LastName = $_."LastName"
      Alias = $UserCN
      ResetPasswordOnNextLogon = $False
      SAMAccountName = $UserCN
      #Database = $Database
      }

	# Create the user and mailbox using Microsoft Exchange PowerShell cmdlets
	$User = New-Mailbox @MailUser -WarningAction SilentlyContinue

	# Build a hashtable containing additional user information
    $UserProperties = @{
      Identity = $UserDN
      Office = $_."Office Telephone"
      Department = $_."Department"
      Title = $_."Job Title"
      }

    # Bind to new user to modify additional properties

	Set-ADUser @UserProperties

    # If user in not an employee, account expires

    $Relationship = $_."Relationship"
	If ($Relationship -ne "Employee") `
		{Set-ADUser -Identity $UserDN `
                    -AccountExpirationDate $_."Contract Expiration Date"
         Write-Verbose "$UserCN relationship is $Relationship so account expiration date is set"
         }
	
	# Create a custom e-mail message from a template
	# Open the document template \\DC1\Install\Welcome.htm
	$Template = Get-Content \\DC1\Install\Welcome.htm


	# Replace placeholders <...> with actual values for this user and division

	$MessageText = $Template -Replace ("<division_name>",("Division" + $DivisionNumber))
	$MessageText = $MessageText -Replace ("<user_name>",($_."First Name"))
	$MessageText = $MessageText -Replace ("<admin_name>",$ENV:UserName)
    Write-Verbose "Created custom welcome message for $UPN"
 
    # Send a mail message to the user welcoming them to the Division
    Send-MailMessage -To $EMailAddress `
                     -Subject "Welcome to $DivisionName" `
                     -Body [string]$MessageText `
                     -SMTPServer $MailHost `
                     -From "$ENV:UserName@$Domain.com" `
                     -BodyAsHTML `
                     -Credential $Credentials

    Write-Verbose "Welcome message sent to $EMailAddress"
	
} # Done creating users



Write-Host "All done creating $DivisionName users"
