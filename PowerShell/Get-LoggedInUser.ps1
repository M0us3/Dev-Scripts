Function Get-LoggedInUser {

    <#
.SYNOPSIS
    This script will get the currently logged on user on a computer
 
 
.NOTES
    Name: Get-LoggedInUser
    Author: Nick Lindstrom
    Version: 0.5
    DateCreated: 10-08-2021
 
 
.EXAMPLE
    Get-LoggedInUser -ComputerName abc-123456
 
 
.LINK
    
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$ComputerName
    )
        
        # Ping the computer to make sure it is online, if it does not respond display error
        If (Test-Connection -ComputerName $ComputerName -Count 1 -ErrorAction SilentlyContinue) {

            # Get the currently logged in user
            Get-WmiObject -ComputerName $ComputerName -Class Win32_ComputerSystem | Select-Object UserName
        }
            else {Write-Host "The computer appears to be offline, verify the computer name"}
          
