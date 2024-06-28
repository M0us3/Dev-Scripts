# Define a function to check if a computer name exists in Active Directory
function Check-ComputerInAD {
    param (
        [string]$computerName
    )
    try {
        # Use the Get-ADComputer cmdlet to check if the computer exists
        $adComputer = Get-ADComputer -Identity $computerName -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

# Assuming the input text file contains a list of computer names (one name per line)
$input_text_file = "$home\Documents\SCCM Installs\DeviceList.txt"
$output_csv_file = "$home\Documents\SCCM Installs\ADCheck.csv"

# Read the list of computer names from the input text file
$computerNames = Get-Content -Path $input_text_file

# Initialize an array to store the results
$results = @()

# Process each computer name
foreach ($computerName in $computerNames) {
    $existsInAD = Check-ComputerInAD -computerName $computerName
    $result = [PSCustomObject]@{
        ComputerName = $computerName
        ExistsInAD = $existsInAD
    }
    $results += $result
}

# Write the results to a CSV file
$results | Export-Csv -Path $output_csv_file -NoTypeInformation

Write-Host "Results written to $output_csv_file"