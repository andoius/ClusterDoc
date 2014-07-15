Clear-Host

#Header

$Header = @"
<style>
TABLE {border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}
TH {border-width: 1px;padding: 3px;border-style: solid;border-color: black;background-color: #6495ED;}
TD {border-width: 1px;padding: 3px;border-style: solid;border-color: black;}
</style>
<title>
SQL Server Cluster Report
</title>
"@

$NodeHeader = @"
<style>
TABLE {border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}
TH {border-width: 1px;padding: 3px;border-style: solid;border-color: black;background-color: #6495ED;}
TD {border-width: 1px;padding: 3px;border-style: solid;border-color: black;}
</style>
<title>
SQL Server Cluster Node Report
</title>
"@

$Pre = "<br><H1>SQL Server Cluster.</H1><br>"
$Post = "<BR>"

#Cluster
Write-Host "CLUSTER"  -BackgroundColor "Black" -ForegroundColor "Yellow"
Write-Host "-------"  -BackgroundColor "Black" -ForegroundColor "Yellow"
[string] $ClusterName = Get-Cluster 
write-host "Cluster Name:= ${Cluster}"
Write-Host " "
$Cluster | Select Name,Domain | ConvertTo-HTML -Head $Header -PreContent $Pre -PostContent $Post | Out-File C:\Admin\Docs\Report.html



$Pre = "<br><H1>Nodes</H1><br>"
$Post = "<BR>"
#Nodes 
Write-Host "NODES" -BackgroundColor "Black" -ForegroundColor "gray"
Write-Host "-----" -BackgroundColor "Black" -ForegroundColor "gray"
$NodeReport = @()
$Nodes = @()
$Nodes = Get-ClusterNode -Cluster $ClusterName 
foreach ( $Node in $Nodes ) 
{
$NodeState =$Node | % { $_.State}

Write-Host "Node Name:= ${Node}" , "State := ${NodeState}"
$row = New-Object -Type PSObject -Property @{
	   		NodeName = $Node | % { $_.Name }
			NodeState = $NodeState
			
}
$NodeReport += $row
}
$NodeReport = $NodeReport | ConvertTo-Html  -PreContent $Pre -PostContent $Post | Out-File C:\Admin\Docs\Report.html -append
Write-Host " "

#Groups 
Write-Host "Groups" -BackgroundColor "Black" -ForegroundColor "Green" 
Write-Host "------" -BackgroundColor "Black" -ForegroundColor "Green" 
#Get list of cluster groups.            
$clustergroup = get-clustergroup -cluster $clustername            
            
#Loop through all groups. Create array            
$groupArray = @()            
$groupNum = 0            
foreach($group in $clustergroup)            
{            
$groupArray += ,@($groupNum,$group.name.tostring(),            
$group.ownernode.tostring(),$group.state.tostring())            
$groupNum++  


$GroupName=$Group | % { $_.Name}
$GroupState = $Group | % { $_.State}
Write-Host "Group Name:= ${GroupName}" , "State := ${GroupState}"        
}  
Write-Host " "



#Resources 
Write-Host "Resources" -BackgroundColor "Black" -ForegroundColor "cyan" 
Write-Host "---------" -BackgroundColor "Black" -ForegroundColor "cyan" 

foreach($gA in $groupArray)            
{            
$now = (get-date).tostring('HH:mm:ss -')            
$gAName = $gA[1]            
$gAOwner = $gA[2]            
$gAState = $gA[3]  

Write-host $gAName -BackgroundColor "Black" -ForegroundColor "DarkMagenta"

if ( $gAState -eq "Online" )
{


$ResourceArray=@()
$groupNum = 0 

$ClusterResources = Get-ClusterResource |where OwnerGroup -eq $gAName 

foreach ($Resource in $ClusterResources )
{
$ResourceArray += ,@($groupNum,$Resource.Name.tostring(),
$Resource.ResourceType.tostring(),$Resource.State.tostring())
$groupNum++  



$ResourceName=$Resource | % { $_.Name}
$ResourceState = $Resource | % { $_.State}
$ResourceType = $Resource | % { $_.ResourceType}
Write-Host "Resource Name:= ${ResourceName}" , "State := ${ResourceState}" , "Resource Type := ${ResourceType}" 
}


}
#$NodeReport = $NodeReport | ConvertTo-Html -Head $Header | Out-File C:\Admin\Docs\NodeReport.html
#Write-Host " "
#Write-Host "Resource Name:= ${ResourceName}" , "Resource Type := ${ResourceType}"  , "State := ${ResourceState}"




if ( $gAState  -eq "Offline"  )
{

Write-Host "Group Name:= ${gAName}" , "State := ${gAState}"        -BackgroundColor "Black" -ForegroundColor "red"
}        
          
}
Write-Host " "