function Copy-FolderToComputers {
    param (
        [string]$computerListPath,
        [string]$sourceFolder,
        [string]$destinationFolder,
        [string]$logFilePath
    )

    # Get the list of computers
    $computers = Get-Content -Path $computerListPath

    foreach ($computer in $computers) {
        Write-Host "Processing $computer"

        # Test if the computer is online
        if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
            Write-Host "$computer is online"

            # Check if the folder is present
            $folderExists = Invoke-Command -ComputerName $computer -ScriptBlock {
                param($destinationFolder)
                Test-Path -Path $destinationFolder
            } -ArgumentList $destinationFolder

            if (-not $folderExists) {
                # Create the folder
                Invoke-Command -ComputerName $computer -ScriptBlock {
                    param($destinationFolder)
                    New-Item -ItemType Directory -Path $destinationFolder
                } -ArgumentList $destinationFolder
            }

            # Copy the folder and its content
            try {
                $session = New-PSSession -ComputerName $computer
                Copy-Item -Path $sourceFolder -Destination $destinationFolder -ToSession $session -Recurse -Force -ErrorAction Stop
                Write-Host "Copy to $computer completed successfully"
            }
            catch {
                Write-Host "Error copying to $computer: $_"
                "$computer: $_" | Out-File -Append -FilePath $logFilePath
            }
            finally {
                Remove-PSSession -Session $session
            }
        }
        else {
            Write-Host "$computer is offline"
            "$computer is offline" | Out-File -Append -FilePath $logFilePath
        }
    }
}


# Call by  Copy-FolderToComputers -computerListPath "C:\computers.txt" -sourceFolder "C:\source" -destinationFolder "C:\destination" -logFilePath "C:\copy.log"
