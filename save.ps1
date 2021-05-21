#Script sauvegardant les process en cours dans un dossier puis le copie-colle dans un autre dossier partagé accessible sur le réseau

#Sauvegarde des process en cours dans un fichier txt 
Get-Process | Out-File -FilePath "C:\Users\test\Documents\Process\process.txt"

#Copie du fichier txt dans le dossier partagé
Copy-Item -Path C:\Users\test\Documents\Process\process.txt -Destination \\SERVEUR\Sauvegarde\Process\process.txt