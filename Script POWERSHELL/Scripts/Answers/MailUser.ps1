$team = Read-Host "EnterTeam"
$name = "Staff" + $team 
$password = Read-Host "EnterNewPassword" -AsSecureString -force
New-Mailbox -name $name -SamAccountName $name `
-userprincipalname ($name + "@course969.com") `
-organizationalunit "Course969.com/Team16/Users" `
-password $password -Database "MX1\Mailbox Database"
