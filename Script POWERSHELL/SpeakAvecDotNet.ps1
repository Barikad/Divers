
########## Installer SAPI au pr�alable ########
# $sp = New-Object -COMObject "SAPI.spVoice"
# $sp.Speak("Bonjour. Ici Powershell")

############### Autre Solution OK pour Win 7 et 8 ###########
# Sans installer SAPI, car d�j� pr�sent

Add-Type -AssemblyName System.speech
$sp = New-Object system.speech.synthesis.speechsynthesizer
$sp.rate = -10  # rate va de -10 � 10
$sp.Speak("Ma�tre Corbeau, sur un arbre perch�, Tenait en son bec un fromage. Ma�tre Renard, par l'odeur all�ch�, Lui tint � peu pr�s ce langage :H� ! bonjour, Monsieur du Corbeau.")
