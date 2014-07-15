Function Get-InstalledSQLFeatures([string] $Computer)
{

$Path = $Location
${LocationCSV} = $Path  +"\SQLFeatures_${Computer}.csv"
${LocationXML} = $Path  +"\SQLFeatures_${Computer}.XML"


#SQL Instances
$server = $Computer
$keypath = "Software\Microsoft\Microsoft SQL Server\Instance Names\SQL"
$roottype = [Microsoft.Win32.RegistryHive]::LocalMachine
$rootkey = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey($roottype, $server)
$rootkey = $rootkey.OpenSubKey($keypath)


## Setup Table

$out=@()

Foreach($instance in $rootkey.GetValueNames()){

$InstancePath = $rootkey.GetValue("$instance")

$keypath1 = "Software\Microsoft\Microsoft SQL Server\${InstancePath}\Setup"
$roottype1 = [Microsoft.Win32.RegistryHive]::LocalMachine
$rootkey1 = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey($roottype1, $server)
$rootkey1 = $rootkey1.OpenSubKey($keypath1)

$keypath1

$Instances =New-Object -TypeName PSObject -Property @{
"Type" = "SQL"
"Name" = $Instance
"Path" = $InstancePath
"Features" = $rootkey1.GetValue("FeatureList")
}
$out += $Instances

}

#OLAP Instances
$server = $Computer
$keypath = "Software\Microsoft\Microsoft SQL Server\Instance Names\OLAP"
$roottype = [Microsoft.Win32.RegistryHive]::LocalMachine
$rootkey = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey($roottype, $server)
$rootkey = $rootkey.OpenSubKey($keypath)


Foreach($instance in $rootkey.GetValueNames()){

$InstancePath = $rootkey.GetValue("$instance")

$keypath1 = "Software\Microsoft\Microsoft SQL Server\${InstancePath}\Setup"
$roottype1 = [Microsoft.Win32.RegistryHive]::LocalMachine
$rootkey1 = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey($roottype1, $server)
$rootkey1 = $rootkey1.OpenSubKey($keypath1)

$keypath1

$Instances =New-Object -TypeName PSObject -Property @{
"Type" = "OLAP"
"Name" = $Instance
"Path" = $InstancePath
"Features" = $rootkey1.GetValue("FeatureList")
}
$out += $Instances

}

$out  |export-csv -path ("${LocationCSV}") -NoTypeInformation
return  $out 
}
