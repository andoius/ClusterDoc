function GetClusterNodes([string] $ClusterName)
{

$Path = $Location
${LocationCSV} = $Path  +"\ClusterNodes.csv"
${LocationXML} = $Path  +"\ClusterNodes.XML"


write-host "Clustername= ${ClusterName}"
write-host "ClusterNodes"

$ClusterNodes = Get-ClusterNode -cluster  "${ClusterName}"
$ClusterNodes |Select Name,Id,State, GroupType   |export-csv -path ("${LocationCSV}") -NoTypeInformation #-Append
write-host "<- ClusterNodes"
return $ClusterNodes
}