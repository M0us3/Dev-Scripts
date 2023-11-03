.DESCRIPTION
 The script will query AzureAD and pull relevant information for the user and devices that is registered by the user
.PARAMETER Param1
  N/A
.INPUTS
  N/A
.OUTPUTS
  N/A
.NOTES
  Version:        1
  Author:         Nick Lindstrom
  Creation Date:  
  Purpose/Change: 
.EXAMPLE
  Get-AzureADUserInformation -ObjectID user@contoso.com
#>

function Get-AzureADUserInformation
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Username
		[Parameter(Mandatory=$false)]
        [string]$Devices
    )

    Process
    {
        Write-Output = "****** This script will collect user information and devices registered by the user ******"
        $Username = Read-Host 'Enter the email address or ObjectID of the user: '
		
    }
    function Get-Hardware { foreach $device in $Devices
        param (
            $Devices = Get-AzureADUserRegisteredDevice -ObjectId $Username
            Write-Output $Devices
        )
        
    }
}
