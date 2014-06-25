# Test du switch

$a = "Bonjour"

switch ($a)
{
    "Hello"     { Write-Output "Hello" }
    "Bonjour"   { Write-Output "Bonjour" }
    "Au revoir" { Write-Output "Au revoir" }
    Default     { Write-Output "Rien du tout" }
}
