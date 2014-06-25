# Script pour effectuer une action sur des serveurs distants
# dont les noms sont dans un fichier CSV
# Svend Albertsen

# 23/02/2014 - Ajouté ceci cela
# 12/02/2014 - Vesrion initiale

# Le fichier CSV est de la forme suivante (par exemple) :
# Ordi
# MX1
# DC1
# SP1


$LaDate = Get-Date -UFormat "%Y%m%d-%H%M%S"

$Dossier = "C:\Users\Admin40"
$FichierCSV = $Dossier + "\liste.csv"
$FichierResultat = $Dossier + "\Resultats-Moulinette-" + $LaDate + ".txt"

# DEL $FichierResultat

cd $Dossier

$serveurs = Import-Csv $FichierCSV
$serveurs | ForEach-Object { 
  Write-Output ( "=============== " + $_.ordi + " ===============" )
  Invoke-Command -ComputerName $_.ordi { ipconfig /all }
} >> $FichierResultat

notepad $FichierResultat
dir
