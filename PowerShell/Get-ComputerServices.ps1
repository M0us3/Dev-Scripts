$OU = "CN=Computername,OU=City,OU=State,DC=Contoso,DC=com"
$Computers = ''

# $Computers = @(Get-adcomputer -filter * -searchbase $OU | fl -property Name | out-string)

foreach ($computer in $computers) {

	$pingtest = test-connection -computername $computer -count 1 -Quiet -erroraction SilentlyContinue
    if ($pingtest){
     $servicestatus = (Get-Service -name wuauserv | fl -property Name, Status, StartType | out-string)
    write-host $computer $servicestatus
    }
    else {Write-Host($Computer + " is offline")}
}


$Computers = ''

foreach ($computer in $computers) {

	$pingtest = test-connection -computername $computer -count 1 -Quiet -erroraction SilentlyContinue
    if ($pingtest){
     $servicestatus = (Get-Service -name wuauserv | fl -property Name, Status, StartType | out-string)
    write-host $computer $servicestatus
    }
    else {Write-Host($Computer + " is offline")}
}
