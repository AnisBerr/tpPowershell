#Script simple création utilisateurs 
Write-Host "créations d'utilisateurs"

#Nombre d'utilisateurs 
[int] $nb = Read-Host "Nombre d'utilisateurs à créer"

#Groupe utilisateur
$grp = Read-Host "Groupe des utilisateurs"
New-ADGroup $grp -GroupScope Global

#création des utilisateurs selon le nombre renseigné et leur ajout dans l'AD

for ($i=1; $i -le $nb ;$i++)
{
    $nom = Read-Host "Nom de l'utilisateur"
    $login = Read-Host "Login de l'utilisateur"
    $mail = Read-Host "Mail de l'utilisateur"
    $mdp = Read-Host "Mot de passe de l'utilisateur (attention aux exigences de complexités"
    New-ADUser -Name $nom -SamAccountName $login -UserPrincipalName $login@formation.local -AccountPassword (ConvertTo-SecureString -AsPlainText $mdp -Force) -PasswordNeverExpires $true -CannotChangePassword $true -Enabled $true
    Write-Host "$nom a été créé"
    Add-ADgroupMember -identity $grp -Members $nom
    Write-Host "$nom a été ajouté à $grp"
}


#Création fichier csv des utilisateurs créés
Get-ADGroupMember $grp | Select-Object name | Export-Csv -path C:\csv\$grp.csv -Encoding UTF8

Write-Host "Fichier CSV des comptes de $grp créés"
Write-Host "Fin du script"