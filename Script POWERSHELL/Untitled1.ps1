# Lister les services en couleur

Get-Service | `

Sort-Object -Property DisplayName,Status | `

ForEach-Object { 
    switch ($_.Status)
    {
      'Stopped' { Write-Host -ForegroundColor RED   "AAAAAAAAAA" }
      'Running' { Write-Host -ForegroundColor GREEN "BBBBBBBBBB" }
      Default   { Write-Host -ForegroundColor WHITE "Etat inconnu" }
    }
}
