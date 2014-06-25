# Utilisation de Write-Verbose et de Write-Debug

cls
#$VerbosePreference = 'continue'
$VerbosePreference = 'SilentlyContinue'
$DebugPreference = 'continue'
Write-Output "Bonjour"
Write-Verbose "Je suis verbeux"
Write-Debug "Je suis debugguant"

