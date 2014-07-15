#Source all the functions relate to CheckSQL
#trap [System.Exception]
#{
#    write-host "    Loading FAILED" -background "RED" -foreground "BLACK"
#    continue;
#}



Write-Host "***********************"
Write-Host "** Loading Functions **"
Write-Host "***********************"

Write-Host " Loading _Cluster.ps1"
. ./_Cluster.ps1


Write-Host " Loading _ClusterGroup.ps1"
. ./_ClusterGroup.ps1


Write-Host " Loading _ClusterResources.ps1"
. ./_ClusterResources.ps1

Write-Host " Loading _ClusterNetwork.ps1"
. ./_ClusterNetwork.ps1

Write-Host " Loading _ClusterNodes.ps1"
. ./_ClusterNodes.ps1

Write-Host " Loading checkOS.ps1"
. ./_checkOS.ps1


Write-Host " Loading _SQLFeatures.ps1"
. ./_SQLFeatures.ps1


Write-Host " Loading CheckNetwork.ps1"
. ./_CheckNetwork.ps1

#Write-Host " Loading checkSQLVersion.ps1"
#. ./_CheckSQLVersion.ps1



#Write-Host " Loading checkconfiguration.ps1"
#. ./_checkconfiguration.ps1


#Write-Host " Loading checkinstance.ps1"
#. ./_checkinstance.ps1

#Write-Host " Loading CheckSQLFunctions.ps1"
#. ./_CheckSQLFunctions.ps1

#Write-Host " Loading checkdatabases.ps1"
#. ./_checkdatabases.ps1


#Write-Host " Loading fnDumpObjecttoXML.ps1"
# . ./fnDumpObjecttoXML.ps1

Write-Host "**********************"
Write-Host "** Functions Loaded **"
Write-Host "**********************"
