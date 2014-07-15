function GetClusterGroups
( [String] $ClusterName)
{

$Path = $Location
${LocationCSV} = $Path  +"\ClusterGroups.csv"
${LocationXML} = $Path  +"\ClusterGroups.XML"


Write-Host "Getting Cluster Groups"

$Clustergroups = get-clustergroup -cluster $ClusterName   



#Loop through all groups. Create array            
$groupArray = @()            
$groupNum = 0            
foreach($group in $Clustergroups)            
{            
$groupArray += ,@($groupNum,$group.name.tostring(), $group.ownernode.tostring(),$group.state.tostring())            
$groupNum++  


$GroupName=$Group | % { $_.Name}
$GroupState = $Group | % { $_.State}


Write-Host "Group Name:= ${GroupName}" , "State := ${GroupState}"   

}  
Write-Host " "



$Clustergroups |Select Cluster,Name,IsCoreGroup,State, GroupType   |export-csv -path ("${LocationCSV}") -NoTypeInformation -Append
return  $groupArray 
}