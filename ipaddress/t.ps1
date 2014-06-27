<#
http://social.technet.microsoft.com/Forums/scriptcenter/en-US/8b89a4a3-29e4-400d-bff0-63cfb8153866/powershell-finding-ipv4-address-using-wmi

#>

$strComputer ="."
$colItems = Get-WmiObject Win32_NetworkAdapterConfiguration -Namespace "root\CIMV2" | where{$_.IPEnabled -eq "True"}

foreach($objItem in $colItems)
{
    if($objItem.Description -match "VirtualBox")
    {
	continue
    }

    if($objItem.IPAddress[0].Length -lt 1)
    {
	continue
    }

    # Write-Host "IP Address:" $objItem.IPAddress[0]
    # Write-Host "MAC Address:" $objItem.MACAddress

    # write-host "Caption: " $objItem.Caption
    # write-host "Description: " $objItem.Description
    # write-host "Index: " $objItem.Index
    # write-host "MAC Address: " $objItem.MACAddress
    # write-host "MAC Address: " $objItem.DNSServerSearchOrder

    # Write-Host "---------------"
    write-host $objItem.Description
}