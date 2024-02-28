<#
.SYNOPSIS
Uninstall ConfigMgr Agent

.DESCRIPTION 
This PS script uninstalls the SCCM client from the remote Windows computer.

.PARAMETER ccmSetupPath
Define the path to ccmsetup.exe

.NOTES
Version: 1.0
Published Date: 28-February-2024
Updated Date: 28-February-2024
Author: Prajwal Desai
Website: https://www.prajwaldesai.com
Post Link: https://www.prajwaldesai.com/uninstall-sccm-client-remove-configmgr-client/
#>

# Define the path to ccmsetup.exe
$ccmSetupPath = "$env:windir\ccmsetup\ccmsetup.exe"

# Check if ccmsetup.exe exists
if (Test-Path $ccmSetupPath) {
    # Uninstall SCCM client silently
    Start-Process -FilePath $ccmSetupPath -ArgumentList "/uninstall" -Wait -NoNewWindow
    Write-Output "Congratulations!! The SCCM client uninstalled successfully."
} else {
    Write-Output " SCCM client is not installed or the path to ccmsetup.exe is incorrect. Please specify a valid path."
}
