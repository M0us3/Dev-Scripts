function copy-folder {
    param (
      $computers = (Get-Content -Path "$home\Documents\Devicelist.txt"),
      $path = "c$\Tech-Support",
      $OutPutCSV = "$home\Documents\FolderCheck.csv",
      $Result = @()
    )

    foreach($computer in $computers) {

    $Ping = Test-Connection $computer -Count 1 -Quiet
    
    if ($Ping) {

        $PathValid = test-path -Path "\\$computer\$path"

        if ($PathValid) {
            $Result += [PSCustomObject]@{
                ComputerName = $computer
                IsOnline = "Yes"
                FolderIsPresent = "Yes"
            }         
        }
        else{
            $Result += [PSCustomObject]@{
                ComputerName = $computer
                IsOnline = "Yes"
                FolderIsPresent = "No"
                }
            }

        }
    
    else {
        $Result += [PSCustomObject]@{
            ComputerName = $computer
            IsOnline = "No"
            FolderIsPresent = "No"
        }
     }
    }
    $Result | Export-Csv -Path $OutPutCSV -NoTypeInformation
    
}
