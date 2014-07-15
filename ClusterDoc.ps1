Clear-host


## Get cluster info for word doc

#Setup Output Folder
#$global:errorvar=0

#clear-host
. .\_ClusterLib.ps1 

$dir = split-path -parent $MyInvocation.MyCommand.Definition
$Location = $dir + "\Output\" 
# remove the output directory
Remove-Item -Path ${Location} -force -recurse


#Create the output Directory

new-item ${Location} -type directory -force

# Server specifc Items go here



$Location = $dir + "\Output\" 
$ScriptLocation = $dir + "\Scripts\" 

new-item ${Location} -type directory -force
Write-host "Output to: $Location"
Write-host "........................"
Write-host " "

write-host ".....GET HOSTNAME" -ForegroundColor Yellow
## Get Hostname
[String] $Hostname = $env:COMPUTERNAME
write-host "Host := ${Hostname}"

write-host ".....GET CLUSTERNAME" -ForegroundColor Yellow
## Get Cluster Name
$Cl = GetClusterName $Hostname
$ClusterName =  $Cl | % {$_.Name}

write-host ".....GET CLUSTER NODES" -ForegroundColor Yellow
#Get Cluster Nodes
#write-host "Cluster Nodes"


$ClusterNodes = GetClusterNodes $ClusterName 

foreach ($node in $ClusterNodes)
{
# Create Sub Folder to contain files

# Creater string for folder
$NodeLocation =  $Location +"\" + $node 

#Create the folder
new-item ${NodeLocation} -type directory -force


$nodeName = $node | % {$_.Name}
write-host "....NODE:${nodeName}"  -ForegroundColor green

write-host "OS ${nodeName}"
CheckOS $nodeName
write-host "Network ${nodeName}"
CheckNetwork  $node
write-host "Processor ${nodeName}"
CheckProcessor $nodeName 

write-host "Installed SQL Featurtes ${nodeName}"
Get-InstalledSQLFeatures $nodeName
}




$CGArray=@()
$CGArray = GetClusterGroups $ClusterName

foreach ($CG in $CGArray)
{

$NetworkName = GetALLClusterResources $CG[1]
$NetworkName = GetClusterResource $CG[1] "Network Name"
write-host "Network Name = " ${NetworkName}

$NetworkName = GetClusterResource $CG[1] "Physical Disk"
write-host "Physical Disk = " ${NetworkName}

$ClusterNetwork = GetClusterNetwork $ClusterName
}