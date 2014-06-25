# Lister les services en couleur

Get-Service | `

Sort-Object -Property DisplayName,Status | `

ForEach-Object { 
  $etat = $_.Status
  $nom  = $_.DisplayName

    switch ($etat)
    {
      'Stopped' { Write-Host -ForegroundColor RED $nom }
      'Running' { Write-Host -ForegroundColor GREEN $nom }
      Default   { Write-Host -ForegroundColor WHITE "Etat inconnu" }
    }
}
