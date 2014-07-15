function GetClusterNetwork ( [String] $ClusterName )
{

$Path = $Location
${LocationCSV} = $Path  +"\ClusterNetwork.csv"
${LocationXML} = $Path  +"\ClusterNetwork.XML"

$ClusterNetwork   = Get-ClusterNetwork -Cluster $ClusterName
$ClusterNetwork   |export-csv -path ("${LocationCSV}") -NoTypeInformation
}