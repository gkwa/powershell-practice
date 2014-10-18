<#

#>

$f='wget.list'; if(test-path $f){ Remove-Item $f}

$filename = "Unattended.xml"
[xml]$xml = (gc $filename)

[System.Xml.XmlNamespaceManager]$ns = $xml.NameTable
$ns.AddNamespace('urn', "urn:schemas-microsoft-com:unattend")
$ns.AddNamespace('wcm', "http://schemas.microsoft.com/WMIConfig/2002/State")

$packages = $xml.SelectNodes('//urn:servicing/urn:package[@action="install"]', $ns)
$updates = $packages | `
  %{
      $_.SelectSingleNode("./urn:*",$ns) | `
	where { $_.name -match 'Package_for_KB' }
  }

$KBs = $updates |%{ $_.name -replace 'Package_for_KB', '' } | sort

Write-Host ("# {0} packages" -f $KBs.count)

$KBs | %{
    $kb="$_"
    $s = @"
http://support.microsoft.com/kb/$kb
"@  | out-file -append -encoding 'ASCII' wget.list
}

Write-Host "wget -nvc --wait=2 --random-wait --input-file=wget.list"
Write-Host "sh totext.sh"
