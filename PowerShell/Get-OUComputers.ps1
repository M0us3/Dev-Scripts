$OU = "OU=City,OU=State,DC=Contoso,DC=com"
$Computers = @(Get-adcomputer -filter * -searchbase $OU | fl -property Name | out-string)

foreach ($computer in $computers) {
	write-host $computer

}
