
$RemoteEx2013Session = New-PSSession -ConfigurationName Microsoft.Exchange `
                                     -ConnectionUri http://vjexch2013/PowerShell/ `
                                     -Authentication Kerberos -Credential (Get-credential)
Import-PSSession $RemoteEx2013Session 