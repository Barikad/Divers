# Ecriture dans journal evenements

New-EventLog -LogName MesScripts -Source Source1

Write-EventLog -logname MesScripts -source Source1 -eventID 3001 -message "COUCOU"
