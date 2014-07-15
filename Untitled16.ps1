clear-host
$Adapters =@()
$Adapters = Get-NetAdapter
foreach ($Adapter in $Adapters)
{

$AdapterName=$Adapter | % { $_.Name}
$AdapterDescription = $Adapter | % { $_.Description}
$AdapterMAC = $Adapter | % { $_.MACAddress}

$NetSettings = Get-netipconfiguration  -InterfaceAlias $AdapterName
foreach ($Setting in $NetSettings)
{

$SettingIPv4Address=$Setting | % { $_.IPv4Address}
$SettingIPv4DefaultGateway = $Setting | % { $_.IPv4DefaultGateway}

Write-Host "IPv4Address:= ${SettingIPv4Address}" , "IPv4DefaultGateway := ${SettingIPv4DefaultGateway}"
}
Write-Host "Adapter Name:= ${AdapterName}" , "Description := ${AdapterDescription}" , "MACAddress := ${AdapterMAC}" 

}