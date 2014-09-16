$f = "slsserver.xml"
[xml]$xml = gc $f
$s = $xml.body.storage

$s

if($null -eq $s.mysql_use_backup)
{
    Write-Host "mysql_use_backup isnt set properly, setting mysql_use_backup=0 now"
}else{
    Write-Host ("mysql_use_backup={0}" -f $s.mysql_use_backup)
}

[void]$s.SetAttribute("mysql_use_backup", "", "0")

$s

$xml.Save($f)
