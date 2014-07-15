function GetClusterResource
( [String] $OwnerGroup)
{

$Path = $Location
${LocationCSV} = $Path  +"\ClusterResources.csv"
${LocationXML} = $Path  +"\ClusterGroups.XML"


Write-Host "Getting Cluster Resources"

$ClusterResources = $ClusterResources = Get-ClusterResource |where OwnerGroup -eq $OwnerGroup 



#Loop through all groups. Create array            
$ResourceArray = @()            
$groupNum = 0            
foreach($Resource in $ClusterResources)            
{            
$ResourceArray += ,@($groupNum,$Resource.name.tostring(), $Resource.ownernode.tostring(),$Resource.state.tostring())            
$groupNum++  


$ResourceName = $Resource | % { $_.Name}
$ResourceState = $Resource | % { $_.State}
$ResourceType = $Resource | % { $_.ResourceType}

Write-Host "Resource Name:= ${ResourceName}" , "State := ${ResourceState}" , "Resource Type := ${ResourceType}" 


 

}  
Write-Host " "




$ClusterResources |Select Cluster,Name,IsCoreGroup,State, GroupType   |export-csv -path ("${LocationCSV}") -NoTypeInformation -Append
return  $ResourceArray 
}