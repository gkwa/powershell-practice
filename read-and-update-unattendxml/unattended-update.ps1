[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)][alias("u")][string]$unattendedfile='.\Unattended.xml',
    [Parameter(Mandatory=$false)][switch]$scrape,
    [Parameter(Mandatory=$false)][switch]$list
)

function scrape
{
    $f='wget.list'; if(test-path $f){ Remove-Item $f}

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
}

function list
{
    $packages | %{
	$n = $_.SelectSingleNode("./urn:*",$ns) | %{ $_.name }
	#	$l = $_.SelectSingleNode("./urn:location",$ns) | %{ $_.location }
	$t = $_.SelectSingleNode("./ew:packageInfo",$ns) | %{ $_.releaseType }
	#	Write-Host ("type:{0}" -f $t)
	#	Write-Host ("location:{0}" -f $l)
	"{0}`t{1}" -f $t,$n
    } | sort
}

##################################################
# main
##################################################

if('' -ne $unattendedfile){
    if(!(Test-Path $unattendedfile)){
	Write-Host "You didnt use param unattendedfile and I cant file 'Unattended.xml' in current dir, quitting prematurely\n"
	exit(1)
    }
}

$filename = $unattendedfile
[xml]$xml = (gc $filename)
[System.Xml.XmlNamespaceManager]$ns = $xml.NameTable
$ns.AddNamespace('urn', "urn:schemas-microsoft-com:unattend")
$ns.AddNamespace('wcm', "http://schemas.microsoft.com/WMIConfig/2002/State")
$ns.AddNamespace('ew', "urn:schemas-microsoft-com:embedded.unattend.internal.v1")

$packages = $xml.SelectNodes('//urn:servicing/urn:package[@action="install"]', $ns)

if($scrape)
{
    scrape
}
if($list)
{
    list
}
