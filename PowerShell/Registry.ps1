<#
.Synopsis
   Set the local settings and registry keys
.DESCRIPTION
   This script will set the local settings and registry keys during OS deployment or manual onboarding
.FUNCTIONALITY
	Use in SCCM task deployment
#>


# Create folders
New-Item -Path "C:\Company-Support" -ItemType Directory -ErrorAction SilentlyContinue


# Set registry keys

# Set LUA to Disable for Administrators
Set-ItemProperty -Path Registry::"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 0
Set-ItemProperty -Path Registry::"HKLM\SOFTWARE\Microsoft\PolicyManager\default\LocalPoliciesSecurityOptions\UserAccountControl_RunAllAdministratorsInAdminApprovalMode" -Name "Behavior" -Value 8020
Set-ItemProperty -Path Registry::"HKLM\SOFTWARE\Microsoft\PolicyManager\default\LocalPoliciesSecurityOptions\UserAccountControl_RunAllAdministratorsInAdminApprovalMode" -Name "Value" -Value 0

# Set RDP to allow incoming connections
Set-ItemProperty -Path Registry::"HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server]" -Name "fDenyTSConnections" -Value 0
Set-ItemProperty -Path Registry::"HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "SecurityLayer" -Value 2
Set-ItemProperty -Path Registry::"HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 0

# Set Powershell execution policy to Remote Signed
New-ItemProperty -Path Registry::"HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" -Name "ExecutionPolicy" -PropertyType String -Value RemoteSigned

# -------- Network Settings --------
# Set Network Cards Power Management OFF
# Function will be called in the loop, use the function to modify, add or make changes to the settings
Function Set-NetRegistry{
	Set-ItemProperty -Path Registry::"$RegPath\$("$subkey".ToString().PadLeft(4,'0'))" -Name "PnPCapabilities" -Type DWord -Value 24
	Set-ItemProperty -Path Registry::"$RegPath\$("$subkey".ToString().PadLeft(4,'0'))" -Name "AutoPowerSaveModeEnabled" -Value 0
	Set-ItemProperty -Path Registry::"$RegPath\$("$subkey".ToString().PadLeft(4,'0'))" -Name "ReduceSpeedOnPowerDown" -Value 0
	Set-ItemProperty -Path Registry::"$RegPath\$("$subkey".ToString().PadLeft(4,'0'))" -Name "EnablePME" -Value 0
	Set-ItemProperty -Path Registry::"$RegPath\$("$subkey".ToString().PadLeft(4,'0'))" -Name "ULPMode" -Value 0
	Set-ItemProperty -Path Registry::"$RegPath\$("$subkey".ToString().PadLeft(4,'0'))" -Name "EEELinkAdvertisement" -Value 0
}

$RegPath="HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}"
$SubKey=0000

While($SubKey -lt 0021){
try {
	New-Item -Path Registry::"$RegPath\$("$subkey".ToString().PadLeft(4,'0'))" -ErrorAction Stop
	Set-NetRegistry
}
catch {
    Set-NetRegistry
	}
finally {
	$SubKey++
	}
}
# -------- End of network settings --------

# -------- Disable Xbox and Retail services --------

# Xbox Accessory Management Service
Set-ItemProperty -Path Registry::"HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" -Name "Start" -Value 4

# Xbox Live Auth Manager
Set-ItemProperty -Path Registry::"HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" -Name "Start" -Value 4

# Xbox Live Game Save
Set-ItemProperty -Path Registry::"HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" -Name "Start" -Value 4

# Xbox Live Networking Service
Set-ItemProperty -Path Registry::"HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" -Name "Start" -Value 4

# Retail Demo Service
Set-ItemProperty -Path Registry::"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RetailDemo" -Name "Start" -Value 4

# Wwan AutoConfig Service
Set-ItemProperty -Path Registry::"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WwanSvc" -Name "Start" -Value 4

# Wallet Service
Set-ItemProperty -Path Registry::"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WalletService" -Name "Start" -Value 4

# TAPI Server
Set-ItemProperty -Path Registry::"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv" -Name "Start" -Value 4

# Phone service
Set-ItemProperty -Path Registry::"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PhoneSvc" -Name "Start" -Value 4

# NFC and Payments service
Set-ItemProperty -Path Registry::"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SEMgrSvc" -Name "Start" -Value 4

# Geolocation Service
Set-ItemProperty -Path Registry::"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc" -Name "Start" -Value 4

# GameDVR service
Set-ItemProperty -Path Registry::"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BcastDVRUserService_37f2e" -Name "Start" -Value 4

# Maps service
Set-ItemProperty -Path Registry::"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MapsBroker" -Name "Start" -Value 4

# Cellular Time Service
Set-ItemProperty -Path Registry::"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\autotimesvc" -Name "Start" -Value 4

# Fax Service
Set-ItemProperty -Path Registry::"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Fax" -Name "Start" -Value 4

# GameDVR Service
Set-ItemProperty -Path Registry::"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BcastDVRUserService" -Name "Start" -Value 4

# -------- End Xbox and Retails services --------
