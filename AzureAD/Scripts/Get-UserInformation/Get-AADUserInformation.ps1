<#
.SYNOPSIS
  Get information from an Azure AD user 
.DESCRIPTION
 The script will query AzureAD and pull relevant information for the user and devices that is registered by the user
.PARAMETER Param1
  N/A
.INPUTS
  N/A
.OUTPUTS
  Returns user information and group memberships
.NOTES
  Version:        1
  Author:         Nick Lindstrom
  Creation Date:  12/05/2023
  Purpose/Change: Collection of user information
.EXAMPLE
  Get-AzureADUserInformation -ObjectID user@contoso.com
#>
function Get-AADUserInformation
{
      # Test AzureAD connection before running script
      try { 
        Get-AzureADTenantDetail
        Write-Host "***** You're connected to AzureAD *****"
      }
      catch [Microsoft.Open.Azure.AD.CommonLibrary.AadNeedAuthenticationException] {
        Write-Host "***** You are not connected to AzureAD. Connecting to AzureAD. *****"
        Connect-AzureAD
      }

      # Get user information and create and array
      Write-Host "****** This script will collect user information and devices registered by the user ******"
      $UserID = Read-Host 'Enter email or ObjectID of the user'
     
      Write-Host "***** User information *****" 
      Get-AzureADUser -ObjectID $UserID | Select-Object Displayname,UserPrincipalName,AccountEnabled,ObjectID,Mail,Department,JobTitle,PhysicalDeliveryOfficeName
      
      Write-Host "***** User devices *****"
      Get-AzureADUserRegisteredDevice -ObjectId $UserID | Select-Object DisplayName,AccountEnabled,DeviceID,ApproximateLastLogonTimeStamp,DeviceOSType,DeviceOSVersion,DeviceTrustType,IsManaged
      
      Write-Host "***** User group memberships *****"
      Get-AzureADUserMembership -ObjectId $UserID | Select-Object DisplayName,ObjectID,Description,MailEnabled,Mail


      
     # Write-Host $AADUserInfo
     # Write-Host $AADUserGroups
}
