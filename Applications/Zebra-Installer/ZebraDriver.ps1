function DownloadDriver {
    param (
        [Parameter(Mandatory=$true)]
        [string] $PrinterIP
        [string] $PrinterModel
        [string] $PrinterName
        [string] $Choice
    )   
        $PrinterIP = Read-Host "Enter the IP address of the printer: "
        $PrinterName = Read-Host "Enter the name of the printer: "
        Write-Host "Select the model of the printer"
        Write-Host "1 - Zebra  ZT610 - 300 dpi"
        Write-Host "2 - Zebra  ZT610 - 600 dpi"
        Write-Host "3 - Zebra  ZT620 - 300 dpi"

            $Choice = Read-Host "Select the model: "
                switch ($Choice) {
                    "1" {}
                }
        
    function PrinterPort {
        
        try {
            Add-PrinterPort -Name $PrinterIP -PrinterHostAddress $PrinterIP -
        }
        catch {
            
        }
    }
}
