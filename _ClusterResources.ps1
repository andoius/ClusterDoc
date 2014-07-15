function GetALLClusterResources
( [String] $OwnerGroup)
{
write-host "Owner = ${OwnerGroup}"
$Path = $Location
${LocationCSV} = $Path  +"\ClusterALLResources.csv"
${LocationXML} = $Path  +"\ClusterALLResources.XML"


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




$ClusterResources |Select Cluster,ResourceType, Name,IsCoreGroup,State, GroupType,OwnerGroup   |export-csv -path ("${LocationCSV}") -NoTypeInformation -Append
return  $ResourceArray 
}

function GetClusterResource
( [String] $OwnerGroup, [String] $ResourceType)
{

$Path = $Location
${LocationCSV} = $Path  +"\ClusterResource_${OwnerGroup}${ResourceType}.csv"
${LocationXML} = $Path  +"\ClusterResource_${OwnerGroup}${ResourceType}.XML"
Write-Host "Getting Cluster Resource -----> ${OwnerGroup} ", $ResourceType
$ClusterResources = $ClusterResources = Get-ClusterResource |where { $_.OwnerGroup -eq "${OwnerGroup}" -and $_.ResourceType -eq "${ResourceType}" }

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
$ClusterResources  |export-csv -path ("${LocationCSV}") -NoTypeInformation -Append
return  $ResourceName 
}