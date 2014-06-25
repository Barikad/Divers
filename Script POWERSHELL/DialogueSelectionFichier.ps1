# Boite de dialogue de selection d'un fichier

$dialogue = New-Object System.Windows.Forms.OpenFileDialog
dialogue.ShowDialog()
$fichier = $dialogue.FileName
