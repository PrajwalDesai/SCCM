PowerShell script to list all the application deployments
Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1' 
Set-Location P01: 
$FilePath = "C:\powershellscripts\test.csv" Get-CMApplication | Select-Object LocalizedDisplayName,SoftwareVersion,NumberOfDeployments | Export-CSV $FilePath