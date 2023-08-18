<#
.SYNOPSIS
  Script to get OS information from remote computer
.DESCRIPTION
  This script will <Elaborate on what the script does>
.PARAMETER Param1
  Specifies <What? Is the parameter required?>
.INPUTS
  requires a host name otherwise it will use localhost
.OUTPUTS
  A log file in the temp directory of the user running the script
.NOTES
  Version:        0.5
  Author:         Nick Lindstrom
  Creation Date:  11-Nov-2022
  Purpose/Change: Initial script development
.EXAMPLE
  NA
#>

$computername = read-host "Enter the hostname: "

If (Test-Connection -computer $computername) {
	$OSInformation = (Get-wmiobject -computername $computername -Class win32_operatingsystem | Select-Object Version,BuildNumber,OSArchitecture)
	write-host $OSInformation
} Else {
	Write-host $computername " appears to be offline."
}
