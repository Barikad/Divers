# Interception d'erreur

trap 
{
  $MessageErreur = $Error[0] 
  $NumeroLigne = $error[0].InvocationInfo.ScriptLineNumber
  $PositionDansLigne = $error[0].InvocationInfo.OffsetInLine
  Write-Output ("Erreur à la ligne : " + $NumeroLigne + " postion : " + $PositionDansLigne)
  continue
}

$a = 5
$b = 0
Write-Output "DEBUT"
Write-Output ($a / $b)
Write-Output "FIN"
