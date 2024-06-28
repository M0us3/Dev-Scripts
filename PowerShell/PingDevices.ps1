function Ping-Computers {
    # Define an empty array to store the results
    $results = @()

    # Read the computer names from the text file
    $computers = Get-Content -Path "$home\Documents\SCCM Installs\DeviceList.txt"

    # File out put location
    $OutPutCSV = "$home\Documents\SCCM Installs\Status.csv"

    # Loop through each computer
    foreach ($computer in $computers) {
        # Ping the computer
        $ping = Test-Connection -ComputerName $computer -Count 1 -Quiet

        # If the ping is successful, add the computer name and 1 to the array
        # If the ping is not successful, add the computer name and 0 to the array
        if ($ping) {
            $results += New-Object PSObject -Property @{
                ComputerName = $computer
                Ping = "Yes"
            }
        } else {
            $results += New-Object PSObject -Property @{
                ComputerName = $computer
                Ping = "No"
            }
        }
    }

    # Export the results to a CSV file
    $results | Export-Csv -Path $OutPutCSV -NoTypeInformation
}

# Call the function
Ping-Computers