# Comparaison/recherche de chaines

$MaChaine = "ABCDEFGHIJKLMNOP"

# La sous-chaine est-elle présente dans la chaine ?
$Present = $MaChaine -like "*B*"
$Present

# A quelle postion se trouve une sous-chaine ?
$Position = $MaChaine.IndexOf("E")
$Position

