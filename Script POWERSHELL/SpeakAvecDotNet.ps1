
########## Installer SAPI au préalable ########
# $sp = New-Object -COMObject "SAPI.spVoice"
# $sp.Speak("Bonjour. Ici Powershell")

############### Autre Solution OK pour Win 7 et 8 ###########
# Sans installer SAPI, car déjà présent

Add-Type -AssemblyName System.speech
$sp = New-Object system.speech.synthesis.speechsynthesizer
$sp.rate = -10  # rate va de -10 à 10
$sp.Speak("Maître Corbeau, sur un arbre perché, Tenait en son bec un fromage. Maître Renard, par l'odeur alléché, Lui tint à peu près ce langage :Hé ! bonjour, Monsieur du Corbeau.")
