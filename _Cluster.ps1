function GetClusterName
(
[String] $Hostname
)
{

$Path = $Location
${LocationCSV} = $Path  +"\ClusterName.csv"
${LocationXML} = $Path  +"\ClusterName.XML"

$ClusterName  = Get-Cluster -name $Hostname | Select Name, Domain |export-csv -path ("${LocationCSV}") -NoTypeInformation # -Append
$ClusterName  = Get-Cluster -name $Hostname | Select Name
return  $ClusterName #| Select Name
}