.SYNOPSIS
Install Distribution Point role using PowerShell Script

.DESCRIPTION 
This scripts lets you install the Distribution Point role on a server, Enable PXE, PXE password and Multicast options.

.PARAMETER DistributionPoint
This the server name where you would be installing Distribution Point role.

.PARAMETER SiteCode
This is the 3 letter site code.

.PARAMETER PXEpass
This is the PXE password.

.NOTES
Version: 2.0
Published Date: 08-December-2016
Updated Date: 20-July-2023
Author: Prajwal Desai
Website: https://www.prajwaldesai.com
Post Link: https://www.prajwaldesai.com/install-sccm-distribution-point-using-powershell-script/
#>

#Load the Configuration Manager Module
import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')
$Drive = Get-PSDrive -PSProvider CMSite
CD "$($Drive):"

#Site Code and Distribution Point Server Information
$SiteCode = 'IND'
$DistributionPoint = 'CORPSCCM.PRAJWAL.LOCAL'

#Install Site System Server
New-CMSiteSystemServer -ServerName $DistributionPoint -SiteCode $SiteCode

#Optional - Install SCCM IIS Base components
#dism.exe /online /norestart /enable-feature /ignorecheck /featurename:"IIS-WebServerRole" /featurename:"IIS-WebServer" /featurename:"IIS-CommonHttpFeatures" /featurename:"IIS-StaticContent" /featurename:"IIS-DefaultDocument" /featurename:"IIS-DirectoryBrowsing" /featurename:"IIS-HttpErrors" /featurename:"IIS-HttpRedirect" /featurename:"IIS-WebServerManagementTools" /featurename:"IIS-IIS6ManagementCompatibility"  /featurename:"IIS-Metabase" /featurename:"IIS-WindowsAuthentication"  /featurename:"IIS-WMICompatibility"  /featurename:"IIS-ISAPIExtensions" /featurename:"IIS-ManagementScriptingTools" /featurename:"MSRDC-Infrastructure" /featurename:"IIS-ManagementService"

#Install Distribution Point Role
write-host "The Distribution Point Role is being Installed on $DistributionPoint"
Add-CMDistributionPoint -CertificateExpirationTimeUtc "October 10, 2025 10:10:00 PM" -SiteCode $SiteCode -SiteSystemServerName $DistributionPoint -MinimumFreeSpaceMB 1024 -ClientConnectionType 'Intranet' -PrimaryContentLibraryLocation Automatic -PrimaryPackageShareLocation Automatic -SecondaryContentLibraryLocation Automatic -SecondaryPackageShareLocation Automatic

#Define PXE Password
$PXEpass = convertto-securestring -string "password" -asplaintext -force

#Enable PXE, Unknown Computer Support, Client Communication Method
Set-CMDistributionPoint -SiteSystemServerName $DistributionPoint -SiteCode $SiteCode -EnablePxe $True -PXEpassword $PXEpass -PxeServerResponseDelaySeconds 0 -AllowPxeResponse $True -EnableUnknownComputerSupport $True -UserDeviceAffinity "AllowWithAutomaticApproval" -EnableContentValidation $True -ClientCommunicationType HTTP

#Enable Multicast Feature
Add-CMMulticastServicePoint -SiteSystemServerName $DistributionPoint -SiteCode $SiteCode