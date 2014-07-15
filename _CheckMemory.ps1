Get-WMIObject -class Win32_PhysicalMemory | 
Measure-Object -Property capacity -Sum | 
select @{N="Total Physical Ram"; E={[math]::round(($_.Sum / 1GB),2)}}