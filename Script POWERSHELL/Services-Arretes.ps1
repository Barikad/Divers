# Lister services en démarrage automatique mais arrêtés

Get-WmiObject Win32_Service | Where-Object {($_.StartMode -ieq "Auto") -and ($_.State -ieq "Stopped")}


